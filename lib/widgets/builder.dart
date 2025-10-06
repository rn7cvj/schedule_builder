import 'package:datetime_utils/extensions/date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../controller/controller.dart';

part 'default/loaded_builder.dart';
part 'default/loading_builder.dart';
part 'default/error_builder.dart';

part 'default/week_builder.dart';
part 'default/week_page_builder.dart';

part 'default/filter.dart';

typedef WeekBuilder =
    Widget Function(
      BuildContext context,
      DateTime weekBegin,
      DateTime weekEnd,
      DateTime selectedDate, {
      void Function(DateTime date)? onDateTap,
    });

typedef WeekPagesBuilder =
    Widget Function(
      BuildContext context,
      Widget weekPageview, {
      VoidCallback? onPreviousTap,
      VoidCallback? onNextTap,
    });

typedef LoadedBuilder<T extends Identifiable, E> =
    Widget Function(
      BuildContext context,
      List<T> data,
      DateTime date,
      DateTime selectedDate,
      E? extra,
    );

typedef LoadingBuilder =
    Widget Function(BuildContext context, DateTime date, DateTime selectedDate);

typedef ErrorBuilder =
    Widget Function(
      BuildContext context,
      Exception e,
      DateTime date,
      DateTime selectedDate,
    );

typedef DataFilter<T extends Identifiable> =
    bool Function(DateTime date, DateTime selectedData, T data);

class ScheduleBuilder<T extends Identifiable, E> extends HookWidget {
  final int pastWeeksView;
  final int futureWeeksView;

  final ScheduleController<T, E> controller;

  final double weekHeight;
  final WeekBuilder weekBuilder;
  final WeekPagesBuilder weekPagesBuilder;

  final LoadedBuilder<T, E> loadedBuilder;

  final LoadingBuilder loadingBuilder;
  final ErrorBuilder errorBuilder;

  final DataFilter<T> dataFilter;

  final ValueChanged<DateTime>? onDateChanged;

  const ScheduleBuilder({
    super.key,
    this.pastWeeksView = 1,
    this.futureWeeksView = 1,
    required this.controller,
    this.weekHeight = 64.0,
    this.weekBuilder = _defaultWeekBuilder,
    this.weekPagesBuilder = _defaultWeekPageBuilder,
    this.loadedBuilder = _defaultLoadedBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
    this.errorBuilder = _defaultErrorBuilder,
    this.dataFilter = _defaultFilter,
    this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final weeks = useMemoized(() {
      final totalWeeks = pastWeeksView + 1 + futureWeeksView;

      final firstWeekBegin = DateTime.now()
          .roundToFirstDayOfWeek()
          .subtract(Duration(days: pastWeeksView * 7))
          .today();

      return List.generate(
        totalWeeks,
        (index) => (
          firstWeekBegin.add(Duration(days: index * 7)),
          firstWeekBegin.add(Duration(days: index * 7)).roundToLastDayOfWeek(),
        ),
      );
    }, [pastWeeksView, futureWeeksView]);

    final firstDay = weeks.first.$1;
    final totalDays = (pastWeeksView + 1 + futureWeeksView) * 7;

    final weekPage = useState(pastWeeksView);
    final weekController = usePageController(initialPage: pastWeeksView);

    final dayPage = useState(pastWeeksView * 7 + DateTime.now().weekday - 1);
    final dayController = usePageController(
      initialPage: pastWeeksView * 7 + DateTime.now().weekday - 1,
    );

    return BlocBuilder<ScheduleController<T, E>, ScheduleControllerState<T, E>>(
      bloc: controller,
      builder: (context, state) => Column(
        children: [
          SizedBox(
            height: weekHeight,
            child: weekPagesBuilder(
              context,
              PageView.builder(
                onPageChanged: (value) => weekPage.value = value,
                controller: weekController,
                itemCount: weeks.length,
                itemBuilder: (context, index) => weekBuilder(
                  context,
                  weeks[index].$1,
                  weeks[index].$2,
                  state.selectedDate,
                  onDateTap: (value) {
                    final newDayPage = value.difference(firstDay).inDays;

                    final _ = (newDayPage - dayPage.value).abs();

                    dayPage.value = newDayPage;

                    dayController.jumpToPage(newDayPage);

                    controller.selectDate(value);
                    onDateChanged?.call(value);
                  },
                ),
              ),
              onPreviousTap: weekPage.value == 0
                  ? null
                  : () {
                      weekController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
              onNextTap: weekPage.value == weeks.length - 1
                  ? null
                  : () {
                      weekController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                final newDate = firstDay.add(Duration(days: value));

                dayPage.value = value;

                final currentWeekIndex = weekPage.value;
                final currentWeekNumber = weeks[currentWeekIndex].$1
                    .getWeekNumber();
                final newWeekNumber = newDate.getWeekNumber();

                if (newWeekNumber > currentWeekNumber) {
                  weekController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }

                if (newWeekNumber < currentWeekNumber) {
                  weekController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }

                controller.selectDate(newDate);

                onDateChanged?.call(newDate);
              },
              controller: dayController,
              itemCount: totalDays,
              itemBuilder: (context, index) {
                final date = firstDay.add(Duration(days: index));

                if (state.data[date] == null) {
                  return SizedBox.shrink();
                }

                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: state.data[date]!.map(
                    loading: (data) =>
                        loadingBuilder(context, date, state.selectedDate),
                    loaded: (data) {
                      final filtered = data.data
                          .where((e) => dataFilter(date, state.selectedDate, e))
                          .toList();

                      return loadedBuilder(
                        context,
                        filtered,
                        date,
                        state.selectedDate,
                        data.extra,
                      );
                    },

                    error: (data) =>
                        errorBuilder(context, data.e, date, state.selectedDate),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
