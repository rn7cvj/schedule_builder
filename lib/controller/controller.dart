import 'package:datetime_utils/extensions/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../.gen/controller/controller.freezed.dart';
part 'state.dart';

/// Interface that requires any type T to have an id property
abstract interface class Identifiable {
  int get scheduleId;
}

typedef DataLoader<T extends Identifiable> =
    Future<Map<DateTime, List<T>>> Function(DateTime begin, DateTime end);

typedef ExtraLoader<T extends Identifiable, E> =
    Future<E> Function(DateTime date, List<T> data);

class ScheduleController<T extends Identifiable, E>
    extends Cubit<ScheduleControllerState<T, E>> {
  final DataLoader<T> dataLoader;
  final ExtraLoader<T, E>? extraLoader;

  final int pastDaysForCache;
  final int futureDaysForCache;
k
  ScheduleController({
    required this.dataLoader,
    this.extraLoader,
    required DateTime initialSelectedDate,
    this.pastDaysForCache = 7,
    this.futureDaysForCache = 7,
  }) : super(ScheduleControllerState<T, E>(selectedDate: initialSelectedDate)) {
    assert(pastDaysForCache >= 0);
    assert(futureDaysForCache >= 0);

    selectDate(initialSelectedDate);
  }

  Future<void> selectDate(DateTime date, {bool ignoreCache = false}) async {
    date = date.today();

    emit(state.copyWith(selectedDate: date));

    if (state.data[date]?.isLoading == true && !ignoreCache) {
      return;
    }

    if (state.data[date]?.isLoaded == true && !ignoreCache) {
      return;
    }

    final previousData = Map<DateTime, DateState<T, E>>.from(state.data);

    final begin = date.subtract(Duration(days: pastDaysForCache));
    final end = date.add(Duration(days: futureDaysForCache));

    final loadingDays = List<DateTime>.generate(
      end.difference(begin).inDays,
      (index) => begin.add(Duration(days: index)),
    );

    emit(
      ScheduleControllerState(
        data: {
          ...previousData,
          ...Map<DateTime, DateState<T, E>>.fromIterable(
            loadingDays,
            value: (element) => DateState<T, E>.loading(),
          ),
        },
        selectedDate: state.selectedDate,
      ),
    );

    try {
      final response = await dataLoader(begin, end);

      Map<DateTime, DateState<T, E>> loadedStates = {};
      for (final element in loadingDays) {
        final data = response[element] ?? [];
        final extra = await extraLoader?.call(date, data);

        loadedStates[element] = DateState<T, E>.loaded(
          data: data,
          extra: extra,
        );
      }

      emit(
        ScheduleControllerState(
          data: {...previousData, ...loadedStates},
          selectedDate: state.selectedDate,
        ),
      );
    } on Exception catch (e) {
      emit(
        ScheduleControllerState(
          data: {
            ...previousData,
            ...Map<DateTime, DateState<T, E>>.fromIterable(
              loadingDays,
              value: (element) => DateState<T, E>.error(e: e),
            ),
          },
          selectedDate: state.selectedDate,
        ),
      );
    }
  }

  Future<bool> updateValue(
    int id, {
    T? newValue,
    T Function(T prevValue)? updater,
  }) async {
    assert(newValue != null || updater != null);

    final updatedData = Map<DateTime, DateState<T, E>>.from(state.data);

    bool itemFound = false;
    for (final entry in updatedData.entries) {
      final dateState = entry.value;

      if (!dateState.isLoaded) {
        continue;
      }

      final loadedState = dateState as _Loaded<T, E>;
      final itemIndex = loadedState.data.indexWhere(
        (item) => item.scheduleId == id,
      );

      if (itemIndex == -1) {
        continue;
      }

      final prevItem = loadedState.data[itemIndex];

      final newItem = newValue ?? updater?.call(prevItem);

      if (newItem == null) {
        break;
      }

      final updatedItems = List<T>.from(loadedState.data);
      updatedItems[itemIndex] = newItem;

      updatedData[entry.key] = DateState<T, E>.loaded(
        data: updatedItems,
        extra: loadedState.extra,
      );
      itemFound = true;
      break;
    }

    if (!itemFound) {
      return false;
    }

    emit(state.copyWith(data: updatedData));

    return true;
  }

  Future<void> resetCache({bool rerequset = true}) async {
    emit(ScheduleControllerState<T, E>(selectedDate: state.selectedDate));
    if (rerequset) selectDate(state.selectedDate);
  }
}
