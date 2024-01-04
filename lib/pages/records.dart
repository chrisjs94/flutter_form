import 'package:flutter/material.dart';
import 'package:flutter_form/database/databasehelper.dart';
import 'package:flutter_form/ui/dialogs.dart';
import 'package:flutter_form/ui/pages/list_tile_template.dart';

import '../core/scaffolds.dart';
import '../core/routes.dart';
import '../model/record.dart';

class RecordsPage extends StatefulWidget {
  RecordsPage({super.key});
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  List<Record> records = List.empty();

  @override
  void initState() {
    super.initState();

    _loadRecordsFromDatabase();
  }

  Future<void> _loadRecordsFromDatabase() async{
    List<Record> loadedRecords = await widget.databaseHelper.getRecords();
    setState(() {
        records = loadedRecords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds(context).homeScaffold(
      appBarTitle: 'Records page',
      pageBody: ListView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        itemCount: records.length,
        itemBuilder: (context, index) {
          return recordsItemList(context, records[index]);
        }
      ),
      onFABPressed: () async {
        final Record? result = (await Navigator.pushNamed(context, Routes.employeeForm)) as Record?;
        
        if (result != null){
          setState(() {
            records.add(result);
          });

          if (await widget.databaseHelper.insertRecord(result) > 0){
            Dialogs(context).showSnackBar('La información ha sido guardada correctamente.');
          }
          else{
            Dialogs(context).showSnackBar('La información ha sido guardada correctamente.');
          }
        }
      }
    );
  }
}