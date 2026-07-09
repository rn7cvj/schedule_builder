import 'package:datetime_utils/datetime_utils.dart';
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
part 'default/header_builder.dart';

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

typedef HeaderBuilder<T extends Identifiable, E> =
    Widget Function(BuildContext context);

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

/// Called when the selected date changes. [date] — the new selected date.
typedef DateChangedCallback = void Function(DateTime date);

/// Called when the displayed week changes.
/// [weekBegin] — first day of the week, [weekEnd] — last day of the week.
typedef WeekChangedCallback =
    void Function(DateTime weekBegin, DateTime weekEnd);

class ScheduleBuilder<T extends Identifiable, E> extends HookWidget {
  /// How many past weeks to show (affects the page range).
  final int pastWeeksView;

  /// How many future weeks to show.
  final int futureWeeksView;

  /// Schedule controller: holds state, selected date and per-date data.
  final ScheduleController<T, E> controller;

  /// Height of the week strip (top block with weekdays).
  final double weekHeight;

  /// Builder for a single week (row of days) in the top PageView.
  final WeekBuilder weekBuilder;

  /// Builder for the wrapper around the weeks PageView (prev/next arrows, etc.).
  final WeekPagesBuilder weekPagesBuilder;

  /// Builder for the header between the week strip and the day content.
  final HeaderBuilder headerBuilder;

  /// Builder for the day content when data is loaded successfully.
  final LoadedBuilder<T, E> loadedBuilder;

  /// Builder for the day content in the loading state.
  final LoadingBuilder loadingBuilder;

  /// Builder for the day content in the error state.
  final ErrorBuilder errorBuilder;

  /// Filter deciding which items to show for a specific date.
  final DataFilter<T> dataFilter;

  /// Selected-date change callback (tap on a day or swipe of the day page).
  final DateChangedCallback? onDateChanged;

  /// Displayed-week change callback (week strip swipe, nav arrows or automatic
  /// paging when a day crosses into another week).
  final WeekChangedCallback? onWeekChanged;

  const ScheduleBuilder({
    super.key,
    this.pastWeeksView = 1,
    this.futureWeeksView = 1,
    required this.controller,
    this.weekHeight = 64.0,
    this.weekBuilder = _defaultWeekBuilder,
    this.weekPagesBuilder = _defaultWeekPageBuilder,
    this.headerBuilder = _defaultHeaderBuilder,
    this.loadedBuilder = _defaultLoadedBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
    this.errorBuilder = _defaultErrorBuilder,
    this.dataFilter = _defaultFilter,
    this.onDateChanged,
    this.onWeekChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Weeks list for the top PageView: each entry is a (begin, end) week pair.
    // Recomputed only when the number of past/future weeks changes.
    final weeks = useMemoized(() {
      final totalWeeks = pastWeeksView + 1 + futureWeeksView;

      // Begin of the earliest week in range (first weekday, N weeks ago).
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

    // First day of the whole range — the origin for computing page indices.
    final firstDay = weeks.first.$1;
    // Total number of days (pages) in the bottom PageView.
    final totalDays = (pastWeeksView + 1 + futureWeeksView) * 7;

    // Current page of the week strip (index into [weeks]).
    final weekPage = useState(pastWeeksView);
    final weekController = usePageController(initialPage: pastWeeksView);

    // Selected date from controller state — the starting anchor for the day page.
    final anchorDate = controller.state.selectedDate;

    // Current page of the bottom PageView (day index from firstDay).
    final dayPage = useState(pastWeeksView * 7 + anchorDate.weekday - 1);
    final dayController = usePageController(
      initialPage: pastWeeksView * 7 + anchorDate.weekday - 1,
    );

    // Notifies the listener about a displayed-week change by week page index.
    void notifyWeekChanged(int weekIndex) {
      if (onWeekChanged == null) return;
      if (weekIndex < 0 || weekIndex >= weeks.length) return;
      onWeekChanged!(weeks[weekIndex].$1, weeks[weekIndex].$2);
    }

    return BlocBuilder<ScheduleController<T, E>, ScheduleControllerState<T, E>>(
      bloc: controller,
      builder: (context, state) => Column(
        children: [
          // Top block: horizontal week strip.
          SizedBox(
            height: weekHeight,
            child: weekPagesBuilder(
              context,
              PageView.builder(
                // Week swipe: update current page and notify about week change.
                onPageChanged: (value) {
                  weekPage.value = value;
                  notifyWeekChanged(value);
                },
                controller: weekController,
                itemCount: weeks.length,
                itemBuilder: (context, index) => weekBuilder(
                  context,
                  weeks[index].$1,
                  weeks[index].$2,
                  state.selectedDate,
                  // Tap on a specific day in the week strip.
                  onDateTap: (value) {
                    // Index of the selected day relative to the range start.
                    final newDayPage = value.difference(firstDay).inDays;

                    final _ = (newDayPage - dayPage.value).abs();

                    dayPage.value = newDayPage;

                    // Sync the bottom PageView to the selected day without animation.
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
          // Header between the week strip and the day content.
          headerBuilder(context),
          // Bottom block: content of the selected day, paged day by day.
          Expanded(
            child: PageView.builder(
              // Day swipe: update the selected date and, when it crosses the
              // current week boundary, auto-page the week strip.
              onPageChanged: (value) {
                final newDate = firstDay.add(Duration(days: value));

                dayPage.value = value;

                // Compare week number of the current week page and the new day.
                final currentWeekIndex = weekPage.value;
                final currentWeekNumber = weeks[currentWeekIndex].$1
                    .getWeekNumber();
                final newWeekNumber = newDate.getWeekNumber();

                // Day moved into the next week — page the strip forward.
                // (paging triggers the week onPageChanged → onWeekChanged)
                if (newWeekNumber > currentWeekNumber) {
                  weekController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }

                // Day moved into the previous week — page the strip backward.
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

                // No state entry for this date yet — render nothing.
                if (state.data[date] == null) {
                  return SizedBox.shrink();
                }

                // Smoothly switch the day content between states.
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  // Pick a builder depending on the date's data state.
                  child: state.data[date]!.map(
                    loading: (data) =>
                        loadingBuilder(context, date, state.selectedDate),
                    loaded: (data) {
                      // Drop items that don't pass dataFilter.
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
