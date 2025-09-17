part of '../builder.dart';

Widget _defaultWeekPageBuilder(
  BuildContext context,
  Widget weekPageview, {
  VoidCallback? onPreviousTap,
  VoidCallback? onNextTap,
}) {
  return Row(
    children: [
      CupertinoButton(
        onPressed: onPreviousTap,
        padding: EdgeInsets.zero,
        child: Icon(Icons.arrow_back_ios_new),
      ),
      Expanded(child: weekPageview),
      CupertinoButton(
        onPressed: onNextTap,
        padding: EdgeInsets.zero,
        child: Icon(Icons.arrow_forward_ios),
      ),
    ],
  );
}
