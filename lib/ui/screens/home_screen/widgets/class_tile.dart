import 'dart:math';

import 'package:flutter/material.dart';


class ClassTile extends StatelessWidget {
  final bool enabled = Random().nextBool();
  ClassTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      elevation:  enabled ? 12 : 2,
      color: enabled ? null : Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.all(8
        ),
        child: ListTile(
          title: Text("Class name"),
          subtitle: Text("Zoom: 29990909 password: 3493843",
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("9:45 AM"),
              Text("11:45 AM"),
            ],
          ),
        )
      ),
    );
  }
}
