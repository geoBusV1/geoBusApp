import 'package:bgloc/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'studentView.dart';
import 'busDriverView.dart';
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
