import 'package:flutter/material.dart';

import '../../helpers/datehelper.dart';
import '../../model/record.dart';
import '../dialogs.dart';

Column recordsItemList(BuildContext context, Record record){
  return Column(
    children: [
      ListTile(
        title: Text(('${record.firstName!}, ${record.lastName!}')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.description ?? ''),
            Text(record.occupation ?? '')
          ],
        ),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar-man.png'),
        ),
        trailing: Text('Fecha: ${formatDate(record.date ?? DateTime.now())}'),
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