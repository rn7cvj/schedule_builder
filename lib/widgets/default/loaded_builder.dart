part of '../builder.dart';

Widget _defaultLoadedBuilder(
  BuildContext context,
  List<dynamic> data,
  DateTime date,
  DateTime selectedDate,
) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) =>
        ListTile(title: Text(data[index].toString())),
  );
}
