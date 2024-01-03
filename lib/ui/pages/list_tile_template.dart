import 'package:flutter/material.dart';

import '../../helpers/datehelper.dart';
import '../../model/record.dart';
import '../dialogs.dart';

Column recordsItemList(BuildContext context, Record record){
  return Column(
    children: [
      ListTile(
        title: Text(record.label ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.description ?? ''),
            Text('Fecha: ${formatDate(record.date ?? DateTime.now())}')
          ],
        ),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar-man.png'),
        ),
        trailing: Switch(
          value: true,
          onChanged: (value) => {
            print('Switch value changed')
          },
        ),
        onLongPress: () => {
          print('List tile long pressed')
        },
        onTap: (){
          Dialogs(context).showAlert(record.label ?? '',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Descripción: ${record.label}'),
                Text('Descripción: ${formatDate(record.date ?? DateTime.now())}')
              ],
            )
          );
        },
      ),
      const Divider(),
    ],
  );
}