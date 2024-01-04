import 'package:flutter/material.dart';
import 'package:flutter_form/pages/employee.dart';
import 'package:flutter_form/pages/login.dart';
import 'package:flutter_form/pages/records.dart';

class Routes{
  static const String login = '/login';
  static const String records = '/records';
  static const String employeeForm = '/employeeForm';
  static const String mapView = '/mapView';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginPage.withTitle(title: 'Login'),
      records: (context) => RecordsPage(),
      employeeForm:(context) => const EmployeePage()
    };
  }
}