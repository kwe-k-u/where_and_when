import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_and_when/ui/screens/add_class_screen/add_class_screen.dart';
import 'package:where_and_when/utils/helpers/database.dart';
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
            if (await getTapPreference()){
              if (event.location.url != null)
                Clipboard.setData(ClipboardData(text: event.location.url));
              else {
                Clipboard.setData(
                    ClipboardData(text: event.location.meetingId));
                Clipboard.setData(ClipboardData(text: event.location.password));
              }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Copied meeting details to clipboard")
                    )
                );


            } else {
              ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  backgroundColor: Colors.cyanAccent,
                  content: Text("Launch meeting ${event.name}?"),
                  actions: [
                    TextButton(
                      child: Text("No"),
                      onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      },
                    ),
                    TextButton(
                      child: Text("Yes"),
                      onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                        launch(event.location.url!);
                      },
                    )
                  ],
                )
              );
            }
          },
          onLongPress: (){
            showDialog(context: context, builder: (context) => Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Edit event"),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> AddClassScreen(event: event)
                            )
                        );

                      },
                    ),
                    ListTile(
                      title: Text("Delete event"),
                      onTap: ()async{
                        await deleteEvent(context: context, event: event);
                      },
                    ),
                  ],
                ),
              ),
            ));
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
