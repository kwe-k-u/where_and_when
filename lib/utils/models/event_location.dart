

import 'package:where_and_when/utils/constants.dart';

class EventLocation{
  String? url;
  String? meetingId;
  String? password;


  EventLocation({
    required this.url,
    required this.meetingId,
    required this.password
});



  Map<String, dynamic> toJson(){
    return {
      ONLINE_URL : this.url,
      ONLINE_MEETING_ID : this.meetingId,
      ONLINE_PASSWORD : this.password
    };
  }


  factory EventLocation.fromJson(Map<String, dynamic> map){
    return EventLocation(
        url: map[ONLINE_URL],
        meetingId: map[ONLINE_MEETING_ID],
        password: map[ONLINE_PASSWORD]
    );
  }

}