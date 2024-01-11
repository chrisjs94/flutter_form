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
  List<Record> records = List.empty(); String filter = ''; String typeFilter = '';
  List<Record> get filteredRecords {
    return records.where((Record element) {
      if (filter.isEmpty){
        return true;
      }
      else if (typeFilter.isNotEmpty){
        if (typeFilter == "name"){
          return (element.lastName! + element.firstName! + element.middleName!).toLowerCase().trim().contains(RegExp(filter.toLowerCase().trim()), 0);
        }
        else if (typeFilter == "description"){
          return (element.description!).toLowerCase().trim().contains(RegExp(filter.toLowerCase().trim()), 0);
        }
        else {
          return false;
        }
      }
      else{
        return element.label!.toLowerCase().trim().contains(filter.toLowerCase().trim());
      }
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _loadRecordsFromDatabase();
  }

  void _showMessage(String message) {
    Dialogs(context).showSnackBar(message);
  }

  void onSearchAction(String? filter, String? value, String? operation){
    setState(() {
      typeFilter = filter ?? '';
      this.filter = value ?? '';
    });
  }

  Future<void> _loadRecordsFromDatabase() async {
    List<Record> loadedRecords = await widget.databaseHelper.getRecords();
    setState(() {
      records = loadedRecords;
    });
  }

  Future<void> _updateRecord(Record record) async {
    final Record? result = await Navigator.pushNamed(
        context, Routes.employeeForm,
        arguments: record) as Record?;
    if (result != null) {
      if (await widget.databaseHelper.updateRecord(result) > 0) {
        //int index = records.indexWhere((record) => record.idRecord == result.idRecord);
        //setState(() {
        //  records[index] = result;
        //});

        setState(() {
          //Actualizando el state para mostrar los ultimos cambios en el listview
          Dialogs(context)
              .showSnackBar('Se ha actualizado la información correctamente');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds(context).homeScaffold(
      appBarTitle: 'Records page',
      pageBody:
          records.isEmpty ? _emptyImageWidget() : _buildListView(context),
      onSearchAction: onSearchAction,
      onFABPressed: () async {
        final Record? result =
            (await Navigator.pushNamed(context, Routes.employeeForm))
                as Record?;

        if (result != null) {
          setState(() {
            records.add(result);
          });

          if (await widget.databaseHelper.insertRecord(result) > 0) {
            _showMessage('La información ha sido guardada correctamente.');
          } else {
            _showMessage('La información ha sido guardada correctamente.');
          }
        }
      }
    );
  }

  Widget _emptyTextWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _emptyImageWidget() {
    return SafeArea( 
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/nodata.png',
              height: MediaQuery.of(context).size.height *
                  0.3, // Ajusta el tamaño de la imagen según tus necesidades
            ),
            _emptyTextWidget('No hemos encontrado registros'),
          ],
        ),
      ),
    )); 
  }

  ListView _buildListView(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        itemCount: filteredRecords.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: Key(filteredRecords[index].idRecord as String),
              direction: DismissDirection.endToStart,
              onDismissed: (DismissDirection direction) {
                //Move to trash
                widget.databaseHelper
                    .deleteRecord(filteredRecords[index].idRecord as String);
                setState(() {
                  filteredRecords.removeAt(index);
                });
                Dialogs(context).showSnackBar('Registro eliminado');
              },
              background: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.white),
                      Text('Move to favorites',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.delete, color: Colors.white),
                      Text('Move to trash',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              child: recordsItemList(context, records[index], _updateRecord));
        });
  }
}
