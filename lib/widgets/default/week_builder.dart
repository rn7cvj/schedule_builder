part of '../builder.dart';

Widget _defaultWeekBuilder(
  BuildContext context,
  DateTime weekBegin,
  DateTime weekEnd,
  DateTime selectedData, {
  void Function(DateTime date)? onDateTap,
}) {
  final begin = weekBegin.roundToFirstDayOfWeek();
  final end = weekEnd.roundToLastDayOfWeek();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(end.difference(begin).inDays + 1, (index) {
      final date = begin.add(Duration(days: index));

      final isSelected = date.isSameDay(selectedData);

      return Flexible(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          sizeStyle: CupertinoButtonSize.small,
          onPressed: () => onDateTap?.call(date),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
            ),
            constraints: BoxConstraints(minWidth: 48, minHeight: 48),
            padding: EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat("EE").format(date)),
                Text(DateFormat("dd").format(date)),
              ],
            ),
          ),
        ),
      );
    }),
  );
}
