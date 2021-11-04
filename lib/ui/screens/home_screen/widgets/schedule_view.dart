import "package:flutter/material.dart";
import 'package:where_and_when/ui/screens/home_screen/widgets/class_tile.dart';
import 'package:where_and_when/utils/models/event.dart';


class ScheduleView extends StatefulWidget {
  final List<Event> events;
  final bool isToday;
  const ScheduleView({
    Key? key,
    required this.events,
    required this.isToday,
      }) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: widget.events.isNotEmpty ?  ListView.separated(
        separatorBuilder: (context, index) => Container(height: 12,),
        itemCount: widget.events.length,
          itemBuilder: (context, index) {
            return ClassTile(
              isToday: widget.isToday,
              event: widget.events.elementAt(index),
            );
          }
      )
          : Center(
        child: Text("No classes for this day"),
      )
    );
  }
}
