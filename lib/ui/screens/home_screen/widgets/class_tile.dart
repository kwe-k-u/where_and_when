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
  // final bool enabled = Random().nextBool();
  ClassTile({
    required this.event,
    Key? key}) : super(key: key);


  int _state(){ // 0 = disabled   1= green    2 = enabled
    int result = 0;
    DateTime date = DateTime.now();

    //converting all the times into integers
    int start = (event.startTime.hour * 60) + (event.startTime.minute);
    int end = (event.endTime.hour * 60) + (event.endTime.minute);
    int now = (date.hour * 60) + (date.minute);

    //if event is past, disable
    //if current time is between the event start and end, show green

    if (event.days!.contains(date.day)) {//if the event is not today, disable
      if (now < start){ //if event hasn't started yet, enable
        result = 2;
      } else if (now > end){
        result = 0;
      } else { //if event is ongoing, set tile to green
        result = 1;
      }

    }



    return result;
  }


  Color? _tileColor(){
    int status = _state();
    if (status == 0)
      return null;
    else if (status == 1)
      return Colors.greenAccent;
    else
      return  Colors.grey.withOpacity(0.2);
  }




  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      elevation:  _state() < 0 ? 12 : 2,
      color: _tileColor(),
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
