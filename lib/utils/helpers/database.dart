



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' hide Event;
import 'package:where_and_when/utils/constants.dart';
import 'package:where_and_when/utils/models/event.dart';

Future<String> uploadEvent(User user,Event event) async{
  DatabaseReference reference;
  FirebaseDatabase database = FirebaseDatabase.instance;

  //create a new reference if event does not have one
  if (event.reference == null)
    reference = database.reference().child("${user.uid}/events").push();
  else //update the event details at the event's reference
    reference = database.reference().child("${user.uid}/events/${event.reference}");

  reference.set(event.toJson());


  return reference.key;
}



Future<List<Event>> getEvents(User user) async{
  List<Event> events = [];
  FirebaseDatabase database = FirebaseDatabase.instance;

  DataSnapshot data = await database.reference().child("${user.uid}/events").get();
  if (data.exists){
    Map<String, dynamic> map = Map.from(data.value);
    map.forEach((key, value) {
      value[EVENT_REFERENCE] = key;
      events.add(
          Event.fromJson(Map<String, dynamic>.from(value) ));
    });
  }


  return events;

}



Future<void> deleteEvent({required User user, required Event event}) async{

  FirebaseDatabase database = FirebaseDatabase.instance;
  await database.reference().child("${user.uid}/events/${event.reference}").remove();
}