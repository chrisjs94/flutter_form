import 'package:flutter/material.dart';
import 'package:flutter_form/ui/pages/list_tile_template.dart';

import '../core/scaffolds.dart';
import '../core/routes.dart';
import '../data/dummy.dart';
import '../model/record.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolds(context).homeScaffold(
      appBarTitle: 'Records page',
      pageBody: ListView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        itemCount: dummyRecords.length,
        itemBuilder: (context, index) {
          return recordsItemList(context, dummyRecords[index]);
        }
      ),
      onFABPressed: () async {
        final Record? result = (await Navigator.pushNamed(context, Routes.employeeForm)) as Record?;
        
        if (result != null){
          setState(() {
            dummyRecords.add(result);
          });
        }
      }
    );
  }
}