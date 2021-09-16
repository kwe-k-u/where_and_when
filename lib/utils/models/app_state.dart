

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:where_and_when/utils/models/event.dart';

class AppState extends ChangeNotifier{
  User? _user;
  List<Event> _events = [];


  set user (User? u){
    this._user = u;
    notifyListeners();
  }

  set addEvent (Event e) {
    this._events.removeWhere((element) => element.reference == e.reference);
    this._events.add(e);
    notifyListeners();
  }

  set addAllEvents(List<Event> list){
    this._events = list;
    notifyListeners();
  }


  User get user=> this._user!;

  List<Event> get events => this._events;

  List<Event> getEventsByDay(int dayIndex){
    List<Event> list = [];
    this.events.forEach((element) {
      if (element.days!.contains(dayIndex))
        list.add(element);
    });

    return list;
  }


  void removeEvent(Event event){
    this._events.remove(event);
    notifyListeners();
  }




}