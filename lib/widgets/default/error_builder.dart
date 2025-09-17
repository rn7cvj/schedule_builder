part of '../builder.dart';

Widget _defaultErrorBuilder(
  BuildContext context,
  Exception e,
  DateTime date,
  DateTime selectedDate,
) {
  return Center(child: Text(e.toString()));
}
