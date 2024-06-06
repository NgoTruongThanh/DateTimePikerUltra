import 'dart:developer';
import 'package:date_time_picker_ultra/date_time_picker_ultra.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Date Time Picker Ultra',
      home: MyHomePage(title: 'Date Time Picker Ultra'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DateTimePickerUltraDialog(
            widget: const Icon(Icons.access_time_sharp),
            selectedDate: DateTime.now(),
            initialTime: TimeOfDay.now(),
            showDatePicker: true,
            showTimePicker: true,
            onPress: (DateTime dateTime) {
              log(dateTime.toString());
            },
            iconColor: Colors.grey,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
