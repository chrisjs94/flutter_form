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

  Future<void> _updateRecord(Record record) async {
    final Record? result = await Navigator.pushNamed(context, Routes.employeeForm, arguments: record) as Record?;
    if (result != null){
      if (await widget.databaseHelper.updateRecord(result) > 0){
        //int index = records.indexWhere((record) => record.idRecord == result.idRecord);
        //setState(() {
        //  records[index] = result;
        //});

        setState(() {
          //Actualizando el state para mostrar los ultimos cambios en el listview
          Dialogs(context).showSnackBar('Se ha actualizado la información correctamente');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds(context).homeScaffold(
      appBarTitle: 'Records page',
      pageBody: records.isEmpty ? _emptyImageWidget() : _buildListView(context),
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

  Widget _emptyTextWidget(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _emptyImageWidget(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/nodata.png',
              height: 500.0, // Ajusta el tamaño de la imagen según tus necesidades
            ),
            _emptyTextWidget('No hemos encontrado registros'),
          ],
        ),
      ),
    );
  }

  ListView _buildListView(BuildContext context){
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      itemCount: records.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(records[index].idRecord as String),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction){
            //Move to trash
            widget.databaseHelper.deleteRecord(records[index].idRecord as String);
            setState(() {
              records.removeAt(index);
            });
            Dialogs(context).showSnackBar('Registro eliminado');
          },
          background:Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.white),
                  Text('Move to favorites', style: TextStyle(color: Colors.white)),
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
                  Text('Move to trash', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          child: recordsItemList(context, records[index], _updateRecord)
        );
      }
    );
  }
}