import 'package:datetime_utils/extensions/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../.gen/controller/controller.freezed.dart';
part 'state.dart';

typedef DataLoader<T> =
    Future<Map<DateTime, List<T>>> Function(DateTime begin, DateTime end);

class ScheduleController<T> extends Cubit<ScheduleControllerState<T>> {
  final DataLoader<T> dataLoader;

  final int pastDaysForCache;
  final int futureDaysForCache;

  ScheduleController({
    required this.dataLoader,
    required DateTime initialSelectedDate,
    this.pastDaysForCache = 7,
    this.futureDaysForCache = 7,
  }) : super(ScheduleControllerState<T>(selectedDate: initialSelectedDate)) {
    assert(pastDaysForCache >= 0);
    assert(futureDaysForCache >= 0);

    selectDate(initialSelectedDate);
  }

  Future<void> selectDate(DateTime date, {bool ignoreCache = false}) async {
    emit(state.copyWith(selectedDate: date.today()));

    if (state.data[date]?.isLoading == true || !ignoreCache) {
      return;
    }

    if (state.data[date]?.isLoaded == true || !ignoreCache) {
      return;
    }

    final previousData = Map<DateTime, DateState<T>>.from(state.data);

    final begin = date.today().subtract(Duration(days: pastDaysForCache));
    final end = date.today().add(Duration(days: futureDaysForCache));

    final loadingDays = List<DateTime>.generate(
      end.difference(begin).inDays,
      (index) => begin.add(Duration(days: index)),
    );

    emit(
      ScheduleControllerState(
        data: {
          ...previousData,
          ...Map<DateTime, DateState<T>>.fromIterable(
            loadingDays,
            value: (element) => DateState<T>.loading(),
          ),
        },
        selectedDate: state.selectedDate,
      ),
    );

    try {
      final response = await dataLoader(begin, end);

      emit(
        ScheduleControllerState(
          data: {
            ...previousData,
            ...Map<DateTime, DateState<T>>.fromIterable(
              loadingDays,
              value: (element) =>
                  DateState<T>.loaded(data: response[element] ?? []),
            ),
          },
          selectedDate: state.selectedDate,
        ),
      );
    } on Exception catch (e) {
      emit(
        ScheduleControllerState(
          data: {
            ...previousData,
            ...Map<DateTime, DateState<T>>.fromIterable(
              loadingDays,
              value: (element) => DateState<T>.error(e: e),
            ),
          },
          selectedDate: state.selectedDate,
        ),
      );
    }
  }

  Future<void> resetCache({bool rerequset = true}) async {
    emit(ScheduleControllerState<T>(selectedDate: state.selectedDate));
    if (rerequset) selectDate(state.selectedDate);
  }
}
