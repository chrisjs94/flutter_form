import 'package:flutter/material.dart';

class Record{
  String? idRecord;
  String? label;
  String? description;
  DateTime? date;
  Icon? icon;
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? birthday;
  String? gender;
  int? age;
  String? occupation;
  String? profession;
  double? latitude;
  double? longitude;

  Record.empty();

  Record.fromMap(Map<String, dynamic> map){
    idRecord = map['idRecord'];
    label = map['label'];
    description = map['description'];
    //date = DateTime.parse(map['date']);
    //todo: convertir el string a Icon
    firstName = map['firstName'];
    middleName = map['middleName'];
    lastName = map['lastName'];
    birthday = DateTime.parse(map['birthday']) ;
    gender = map['gender'];
    age = map['age'];
    occupation = map['occupation'];
    profession = map['profession'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

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

  Map<String, dynamic> toMap() {
    return {
      'idRecord': idRecord,
      'label': label,
      'description': description,
      'date': date?.toIso8601String(),
      'icon': icon.toString(),
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'birthday': birthday?.toIso8601String(),
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'profession': profession,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  String toSql(){
    return 
      '''CREATE TABLE records(
          idRecord varchar(50) PRIMARY KEY,
          label TEXT,
          description TEXT,
          date varchar(50),
          icon TEXT,
          firstName varchar(100),
          middleName varchar(100),
          lastName varchar(100),
          birthday TEXT,
          age int,
          gender varchar(100),
          occupation varchar(100),
          profession varchar(100),
          latitude float,
          longitude float
        )''';
  }
}