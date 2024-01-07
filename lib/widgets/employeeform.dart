import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/datehelper.dart';
import '../model/record.dart';

class EmployeeForm extends StatelessWidget {
  final Record record; final dynamic onChanged;

  const EmployeeForm({
    required this.record,
    required this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: super.key,
      onChanged: () {
        onChanged(record);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Latitude: ${record.latitude?.toStringAsFixed(8)}'),
                    Text('Longitude: ${record.longitude?.toStringAsFixed(8)}'),
                    Text('Altitude: ${record.altitude?.toStringAsFixed(8)}')
                  ],
                ),
                Column(
                  children: [
                    Text('Accuracy: ${record.accuracy?.toStringAsFixed(5)}'),
                    Text('Provider: ${record.provider?.toUpperCase()}'),
                    Text('Speed: ${record.speed?.toStringAsFixed(5)} m/s'),
                  ],
                )
              ],
            ),
          ),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Label'
            ),
            initialValue: record.label ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              record.label = value
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter description about employee',
              prefixIcon: Icon(Icons.text_fields),
              suffixText: '*',
              /*suffixIcon: GestureDetector(
                onTap: () {
                  record.description = '';
                  onChanged(record);
                },
                child: const Icon(Icons.clear), // Icono a la derecha del campo para borrar
              )*/
            ),
            controller: TextEditingController(
              text: record.description ?? ''
            ),
            initialValue: record.description ?? '',
            /*validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter description about employee';
              }
              return null;
            },*/
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              record.description = value
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
                    record.firstName = value
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
                    record.middleName = value
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
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: (value) => {
              record.lastName = value
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
                record.birthday = pickedDate;
                onChanged(record);
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
              record.occupation = value
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
              record.profession = value
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
                onChanged: (value) => {
                  record.gender = value as String
                },
              ),
              const Text('Male'),
              Radio(
                value: 'Female',
                groupValue: record.gender,
                onChanged: (value) => {
                  record.gender = value as String
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