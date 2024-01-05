import 'package:flutter/material.dart';

import '../../helpers/datehelper.dart';
import '../../model/record.dart';

Column recordsItemList(BuildContext context, Record record, onTapCallback){
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
        onTap: () => onTapCallback(record),
      ),
      const Divider(),
    ],
  );
}