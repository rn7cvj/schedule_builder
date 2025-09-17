import 'package:flutter/material.dart';
import 'package:schedule_builder/controller/controller.dart';
import 'package:schedule_builder/widgets/builder.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("schedule_builder_example")),
      body: ScheduleBuilder(
        controller: ScheduleController<int>(
          dataLoader: (begin, end) async {
            print(
              "request ${begin.toIso8601String()} - ${end.toIso8601String()}",
            );
            await Future.delayed(Duration(milliseconds: 6000));

            final loadingDays = List<DateTime>.generate(
              end.difference(begin).inDays,
              (index) => begin.add(Duration(days: index)),
            );

            final result = Map<DateTime, List<int>>.fromIterable(
              loadingDays,
              value: (element) => List.generate(16, (index) => index * index),
            );

            return result;
          },
          initialSelectedDate: DateTime.now(),
        ),
      ),
    );
  }
}
