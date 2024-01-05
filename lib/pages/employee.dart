import 'package:flutter/material.dart';
import 'package:flutter_form/device/location.dart';
import 'package:flutter_form/helpers/datehelper.dart';
import 'package:flutter_form/ui/circularprogress.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../core/scaffolds.dart';
import '../model/record.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState.newRecord();
}

class _EmployeePageState extends State<EmployeePage> {
  late Record record; LocationData? _currentLocation;

  _EmployeePageState.newRecord(){
    record = Record.empty();
  }

  @override
  void initState() {
    super.initState();
  }

  updateLocationState(LocationData locationData){
    setState(() {
      _currentLocation = locationData;
      record.latitude = _currentLocation?.latitude;
      record.longitude = _currentLocation?.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null && ModalRoute.of(context)!.settings.arguments is Record){
      setState(() {
        record = ModalRoute.of(context)!.settings.arguments as Record;
        _currentLocation = LocationData.fromMap({
          "latitude": record.latitude,
          "longitude": record.longitude,
        });
      });
    }
    else{
      getCurrentLocation(updateLocationState);
    }

    return Scaffolds(context).formScaffoldWithSliverAppBar(
      appBarTitle: !record.isEditing() ? 'Add new record' : 'Edit record',
      onSaveButtonClick: () => Navigator.pop(context, record),
      currentLocation: _currentLocation,
      pageBody: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentLocation == null ? circularProgress() : _form(),
      )
    );
  }

  _form(){
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Label'
            ),
            initialValue: record.label ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              setState(() => {
                record.label = value
              })
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description'
            ),
            initialValue: record.description ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              setState(() => {
                record.description = value
              })
            },
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First name'
                  ),
                  initialValue: record.firstName ?? '',
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => {
                    setState(() => {
                      record.firstName = value
                    })
                  },
                )
              )),

              Expanded(
                child: Padding(padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Middle Name'
                  ),
                  initialValue: record.middleName ?? '',
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => {
                    setState(() => {
                      record.middleName = value
                    })
                  },
                )
              ))
            ],
          ),
          const SizedBox(height: 16),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last name'
            ),
            initialValue: record.lastName ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              setState(() => {
                record.lastName = value
              })
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Birthday'
            ),
            //initialValue: DateFormat('yyyy-MM-dd').format(record.birthday ?? DateTime.now()),
            controller: TextEditingController(
              text: DateFormat('yyyy-MM-dd').format(record.birthday ?? DateTime.now())
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now()
              );

              if (pickedDate != null && pickedDate != record.birthday){
                setState(() {
                  record.birthday = pickedDate;
                });
              }
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            keyboardType: TextInputType.number,
            readOnly: true,
            controller: TextEditingController(
              text: calculateAge(record.birthday ?? DateTime.now())
            ),
            //initialValue: (record.age ?? 0).toString(),
            decoration: const InputDecoration(
              labelText: 'Age'
            )
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: record.occupation,
            decoration: const InputDecoration(labelText: 'Occupation'),
            onChanged: (value) => {
              setState((){
                record.occupation = value;
              })
            },
            items: ['Engineering', 'Licensing', 'Other'].map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList()
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: record.profession,
            decoration: const InputDecoration(labelText: 'Profession'),
            onChanged: (value) => {
              setState((){
                record.profession = value;
              })
            },
            items: ['Engineering', 'Licensing', 'Other'].map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList()
          ),
          const SizedBox(height: 16),

          const Text('Gender'),
          Row(
            children: [
              Radio(
                value: 'Male',
                groupValue: record.gender,
                onChanged: (value) {
                  setState(() {
                    record.gender = value as String;
                  });
                },
              ),
              const Text('Male'),
              Radio(
                value: 'Female',
                groupValue: record.gender,
                onChanged: (value) {
                  setState(() {
                    record.gender = value as String;
                  });
                },
              ),
              const Text('Female'),
            ]
          ),
          const SizedBox(height: 16),

          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Latitude'
            ),
            //initialValue: record.latitude.toString(),
            controller: TextEditingController(
              text: record.latitude.toString()
            ),
            textInputAction: TextInputAction.next
          ),
          const SizedBox(height: 16),

          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Longitude'
            ),
            //initialValue: record.longitude.toString(),
            controller: TextEditingController(
              text: record.longitude.toString()
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () => {
              Navigator.pop(context, record)
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save),
                const SizedBox(width: 5),
                Text(record.isEditing() ? 'Save changes' : 'Add record')
              ],
            )
          )
        ],
      ),
    );
  }
}