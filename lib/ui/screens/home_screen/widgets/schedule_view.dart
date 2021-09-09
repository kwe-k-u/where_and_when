import "package:flutter/material.dart";
import 'package:where_and_when/ui/screens/home_screen/widgets/class_tile.dart';
import 'package:where_and_when/utils/models/event.dart';
import 'package:where_and_when/utils/models/event_location.dart';


class ScheduleView extends StatefulWidget {
  List<Event> events;
  ScheduleView({
    Key? key,
    required this.events
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
            Event current = widget.events.elementAt(index);
            return ClassTile(
              event: Event(
                  name: current.name,
                  notes: current.notes,
                  start: current.startTime,
                  end: current.endTime,
                  location: current.location,
                  days: current.days),
            );
          }
      )
          : Center(
        child: Text("No classes for this day"),
      )
    );
  }
}
