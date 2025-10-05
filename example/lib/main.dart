import 'package:flutter/material.dart';
import 'package:schedule_builder/controller/controller.dart';
import 'package:schedule_builder/widgets/builder.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class ExampleEvent implements Identifiable {
  @override
  final int scheduleId;
  final String title;
  final int value;

  const ExampleEvent({
    required this.scheduleId,
    required this.title,
    required this.value,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("schedule_builder_example")),
      body: ScheduleBuilder<ExampleEvent, dynamic>(
        controller: ScheduleController<ExampleEvent, dynamic>(
          dataLoader: (begin, end) async {
            debugPrint(
              "Request ${begin.toIso8601String()} - ${end.toIso8601String()}",
            );
            await Future.delayed(Duration(milliseconds: 6000));

            final loadingDays = List<DateTime>.generate(
              end.difference(begin).inDays,
              (index) => begin.add(Duration(days: index)),
            );

            final result = Map<DateTime, List<ExampleEvent>>.fromIterable(
              loadingDays,
              value: (element) => List.generate(
                16,
                (index) => ExampleEvent(
                  scheduleId: index,
                  title: 'Event $index',
                  value: index * index,
                ),
              ),
            );

            return result;
          },
          initialSelectedDate: DateTime.now(),
        ),
      ),
    );
  }
}
