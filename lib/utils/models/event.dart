

import 'package:flutter/material.dart';
import 'package:where_and_when/utils/constants.dart';
import 'package:where_and_when/utils/models/event_location.dart';

class Event{
  late String name;
  late String notes;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late EventLocation location;


  Event({
    required this.name,
    required this.notes,
    required this.startTime,
    required this.endTime,
    required this.location
});



  factory Event.fromJson(Map<String, dynamic> map){
    return Event(
        name: map[NAME_COLUMN],
        notes: map[NOTES_COLUMN],
        startTime: map[START_TIME_COLUMN],
        endTime: map[END_TIME_COLUMN],
        location: EventLocation.fromJson(map[LOCATION_COLUMN])
    );
  }



}