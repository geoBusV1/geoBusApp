import 'package:flutter/material.dart';
import 'studentView.dart';
import 'busDriverView.dart';
import 'loginPage.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/BusDriverView':
        return MaterialPageRoute(builder: (_) => BusDriverView());
      case '/StudentView':
        return MaterialPageRoute(builder: (_) => StudentView());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('ERROR!'),),
      );
    });
  }
}