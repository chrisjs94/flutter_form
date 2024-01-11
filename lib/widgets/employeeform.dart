import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/datehelper.dart';
import '../model/record.dart';

class EmployeeForm extends StatefulWidget {
  final Record record;
  final dynamic onChanged;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isValid(){
    return _formKey.currentState?.validate() ?? false;
  }

  EmployeeForm(
      {required this.record, required this.onChanged, super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      onChanged: () {
        setState(() {
          widget.record;
        });
        widget.onChanged(widget.record);
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
                    Text(
                        'Latitude: ${widget.record.latitude?.toStringAsFixed(8)}'),
                    Text(
                        'Longitude: ${widget.record.longitude?.toStringAsFixed(8)}'),
                    Text(
                        'Altitude: ${widget.record.altitude?.toStringAsFixed(8)}')
                  ],
                ),
                Column(
                  children: [
                    Text(
                        'Accuracy: ${widget.record.accuracy?.toStringAsFixed(5)}'),
                    Text('Provider: ${widget.record.provider?.toUpperCase()}'),
                    Text(
                        'Speed: ${widget.record.speed?.toStringAsFixed(5)} m/s'),
                  ],
                )
              ],
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Label'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your label';
              }
              return null;
            },
            initialValue: widget.record.label ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {widget.record.label = value},
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter description about employee',
              prefixIcon: Icon(Icons.text_fields),
              suffixIcon: Icon(Icons.abc_sharp),
              //suffixText: '*',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your description';
              }
              return null;
            },
            initialValue: widget.record.description ?? '',
            textInputAction: TextInputAction.next,
            onChanged: (value) => {widget.record.description = value},
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'First name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        initialValue: widget.record.firstName ?? '',
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => {widget.record.firstName = value},
                      ))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Middle Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your middle name';
                            }
                            return null;
                          },
                          initialValue: widget.record.middleName ?? '',
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) =>
                            {widget.record.middleName = value},
                      )))
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Last name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            initialValue: widget.record.lastName ?? '',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: (value) => {widget.record.lastName = value},
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Birthday'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please pick your first birthday';
              }
              return null;
            },
            //initialValue: DateFormat('yyyy-MM-dd').format(record.birthday ?? DateTime.now()),
            controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd')
                    .format(widget.record.birthday ?? DateTime.now())),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());

              if (pickedDate != null && pickedDate != widget.record.birthday) {
                widget.record.birthday = pickedDate;
                widget.onChanged(widget.record);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
              keyboardType: TextInputType.number,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please pick your birthdate for calculate age';
                }
                return null;
              },
              controller: TextEditingController(
                  text: calculateAge(widget.record.birthday ?? DateTime.now())),
              //initialValue: (record.age ?? 0).toString(),
              decoration: const InputDecoration(labelText: 'Age')),

          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
              value: widget.record.occupation,
              decoration: const InputDecoration(labelText: 'Occupation'),
              onChanged: (value) => {widget.record.occupation = value},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select one option for occupation';
                }
                return null;
              },
              items: ['Engineering', 'Licensing', 'Other'].map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList()),

          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
              value: widget.record.profession,
              decoration: const InputDecoration(labelText: 'Profession'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select one option for profession';
                }
                return null;
              },
              onChanged: (value) => {widget.record.profession = value},
              items: ['Engineering', 'Licensing', 'Other'].map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList()),
          const SizedBox(height: 16),
          const Text('Gender'),
          Row(children: [
            Radio(
              value: 'Male',
              groupValue: widget.record.gender,
              onChanged: (value) => {
                setState(() => widget.record.gender = value as String) 
              },
            ),
            const Text('Male'),
            Radio(
              value: 'Female',
              groupValue: widget.record.gender,
              onChanged: (value) => {
                setState(() => widget.record.gender = value as String) 
              },
            ),
            const Text('Female'),
          ]),
          const SizedBox(height: 16),

          TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Latitude'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Geolocation is not present. Close form and reopen this.';
                }
                return null;
              },
              //initialValue: record.latitude.toString(),
              controller: TextEditingController(
                  text: widget.record.latitude.toString()),
              textInputAction: TextInputAction.next),
          const SizedBox(height: 16),

          TextFormField(
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Longitude'),
            //initialValue: record.longitude.toString(),
            controller:
                TextEditingController(text: widget.record.longitude.toString()),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () => {
                if (widget._formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, widget.record)
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save),
                  const SizedBox(width: 5),
                  Text(
                      widget.record.isEditing() ? 'Save changes' : 'Add record')
                ],
              ))
        ],
      ),
    );
  }
}
