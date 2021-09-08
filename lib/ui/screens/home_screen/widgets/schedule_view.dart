import "package:flutter/material.dart";
import 'package:where_and_when/ui/screens/home_screen/widgets/class_tile.dart';


class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(height: 12,),
        itemCount: 7,
          itemBuilder: (context, index) => ClassTile()
      )
    );
  }
}