

import 'package:flutter/material.dart';
import 'package:where_and_when/utils/constants.dart';
import 'package:where_and_when/utils/models/event_location.dart';

class Event{
  late String name;
  late String notes;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late EventLocation location;
  late List<int?>? days;


  Event({
    required this.name,
    required this.notes,
    required dynamic start,
    required dynamic end,
    required this.location,
    required this.days
}){
    if (start.runtimeType == String)
      this.startTime = _parseTime(start);
    else
      this.startTime = start;

    if (end.runtimeType == String)
      this.endTime = _parseTime(end);
    else
      this.endTime = end;
  }

  TimeOfDay _parseTime(String time){
    List<String> d = time.split(":");
    return TimeOfDay(hour: int.parse(d[0]), minute: int.parse(d[1]));
  }

  String _toString(TimeOfDay time ){
    return "${time.hour}:${time.minute}";
  }


  factory Event.fromJson(Map<String, dynamic> map){
    List<int?>? days = [];
    map[REPEAT_DAYS_COLUMN].forEach((element) => days.add(element));
    return Event(
        name: map[NAME_COLUMN],
        notes: map[NOTES_COLUMN],
        start: map[START_TIME_COLUMN],
        end: map[END_TIME_COLUMN],
        location: EventLocation.fromJson(Map<String, dynamic>.from(map[LOCATION_COLUMN])),
        days: days
    );
  }


  Map<String, dynamic> toJson(){
    return {
      NAME_COLUMN : this.name,
      NOTES_COLUMN : this.notes,
      START_TIME_COLUMN : _toString(startTime),
      END_TIME_COLUMN : _toString(endTime),
      LOCATION_COLUMN : location.toJson(),
      REPEAT_DAYS_COLUMN : this.days
    };
  }



}