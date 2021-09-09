



import 'package:firebase_database/firebase_database.dart' hide Event;
import 'package:where_and_when/utils/models/event.dart';

Future<void> uploadEvent(Event event) async{

  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference reference = database.reference().child("events").push();

  reference.set(event.toJson());
}



Future<List<Event>> getEvents() async{
  List<Event> events = [];
  FirebaseDatabase database = FirebaseDatabase.instance;

  DataSnapshot data = await database.reference().child("events").get();

  if (data.exists){
    Map<dynamic, dynamic> map = Map.from(data.value);
    map.forEach((key, value) {
      Event.fromJson(Map<String, dynamic>.from(value) );
    });
  }


  return events;

}