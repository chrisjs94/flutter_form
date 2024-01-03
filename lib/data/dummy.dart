import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/record.dart';

final List<Record> dummyRecords = [
    Record(
      idRecord: const Uuid().v1(),
      label: '0010252142000A',
      description: 'Mario Enrique Gomez',
      date: DateTime(2023, 12, 31),
      icon: const Icon(Icons.check_circle, color: Colors.green),
      latitude: 12.14255252,
      longitude: -86.2332514
    ),
    Record(
      idRecord: const Uuid().v1(),
      label: '0010252142000A',
      description: 'Ana Maria del Socorro Perez',
      date: DateTime(2023, 12, 30),
      icon: const Icon(Icons.warning, color: Colors.orange),
      latitude: 12.14255252,
      longitude: -86.2332514
    ),
    Record(
      idRecord: const Uuid().v1(),
      label: '0010252142000A',
      description: 'Mambo de los Ángeles Brunildo',
      date: DateTime(2023, 12, 29),
      icon: const Icon(Icons.check_circle, color: Colors.green),
      latitude: 12.14255252,
      longitude: -86.2332514
    ),
    // Agrega más registros según sea necesario
  ];