import 'package:bgloc/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'busLocationStudentView.dart';
import 'busLocationBusDriverView.dart';
import 'loginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
