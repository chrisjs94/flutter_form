import 'package:flutter/material.dart';
import 'package:flutter_form/device/location.dart';
import 'package:flutter_form/helpers/datehelper.dart';
import 'package:flutter_form/ui/circularprogress.dart';
import 'package:flutter_form/widgets/employeeform.dart';
import 'package:flutter_form/widgets/sliverappbarform.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../core/routes.dart';
import '../model/record.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState.newRecord();
}

class _EmployeePageState extends State<EmployeePage> {
  late Record record; LocationData? _currentLocation; bool _firstBuild = true;
  //final GlobalKey<GoogleMapStateBase> _mapKey = GlobalKey<GoogleMapStateBase>();
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _EmployeePageState.newRecord(){
    record = Record.empty();
  }

  @override
  void initState() {
    super.initState();
  }

  void onChanged(Record update){
    setState(() {
      record = update;
    });
  }

  Future<void> viewMapPage() async {
    LocationData newLocation = (await Navigator.pushNamed(context, Routes.mapView, arguments: _currentLocation)) as LocationData;

    setState(() {
      _currentLocation = newLocation;
    });
  }

  Future<void> getCurrentLocation() async {
    _currentLocation = await getLocation();

    setState(() {
      record.latitude = _currentLocation?.latitude;
      record.longitude = _currentLocation?.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_firstBuild){
      if (ModalRoute.of(context)!.settings.arguments != null && ModalRoute.of(context)!.settings.arguments is Record){
        setState(() {
          record = ModalRoute.of(context)!.settings.arguments as Record;
          _currentLocation = LocationData.fromMap({
            "latitude": record.latitude,
            "longitude": record.longitude,
          });
        });
      }
      else {
        getCurrentLocation();
      }
    }

    _firstBuild = false;
    return SliverAppBarMapForm(
      appBarTitle: !record.isEditing() ? 'Add new record' : 'Edit record',
      onSaveButtonClick: () => Navigator.pop(context, record),
      onMapButtonClick: viewMapPage,
      currentLocation: _currentLocation,
      pageBody: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentLocation == null ? circularProgress() : EmployeeForm(
          record: record,
          onChanged: onChanged,
          //key: _formKey,
        )
      )
    );
  }
}