import 'package:flutter/material.dart';

class Record{
  String? idRecord;
  String? label;
  String? description;
  DateTime? date;
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? birthday;
  String? gender;
  int? age;
  String? occupation;
  String? profession;
  Icon? icon;
  double? latitude;
  double? longitude;

  Record.empty();

  Record({
    required this.idRecord,
    required this.label,
    required this.description,
    required this.date,
    required this.icon,
    required this.latitude,
    required this.longitude
  });

  @override
  String toString() {
    return "";
  }
}