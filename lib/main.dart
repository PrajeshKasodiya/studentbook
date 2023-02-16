import 'package:flutter/material.dart';
import 'package:studentbook/view/student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Student(),
    );
  }
}
