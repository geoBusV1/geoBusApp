import 'package:flutter/material.dart';
import 'busLocationStudentView.dart';
import 'busLocationBusDriverView.dart';
import 'loginPage.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/BusLocationBusDriverView':
        return MaterialPageRoute(builder: (_) => BusLocationBusDriverView());
      case '/BusLocationStudentView':
        return MaterialPageRoute(builder: (_) => BusLocationStudentView());
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
