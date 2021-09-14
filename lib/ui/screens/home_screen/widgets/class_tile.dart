import 'dart:math';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_and_when/utils/helpers/shared_preferences.dart';
import 'package:where_and_when/utils/models/event.dart';


class ClassTile extends StatelessWidget {
  final Event event;
  final bool enabled = Random().nextBool();
  ClassTile({
    required this.event,
    Key? key}) : super(key: key);

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
          onTap: () async{
            //todo copy url;
            if (await getTapPreference()){
              if (event.location.url != null)
                ClipboardManager.copyToClipBoard(event.location.url);
              else{
                ClipboardManager.copyToClipBoard(event.location.meetingId);
                ClipboardManager.copyToClipBoard(event.location.password);

              }
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Copied meeting details to clipboard")
                  )
              );

            } else {
              // launch(urlString)
            }
          },
          onLongPress: (){
            //todo show pop with options for delete and edit
          },
          title: Text(event.name, overflow: TextOverflow.ellipsis,),
          subtitle: Text(event.location.url ??
              "ZoomID: ${event.location.meetingId}\nPassword: ${event.location.password}",
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(event.startTime.format(context)),
              Text("to"),
              Text(event.endTime.format(context)),
            ],
          ),
        )
      ),
    );
  }
}
