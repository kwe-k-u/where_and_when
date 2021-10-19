

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_and_when/utils/helpers/shared_preferences.dart';
import 'package:where_and_when/utils/models/event.dart';
import 'package:collection/collection.dart';



FlutterLocalNotificationsPlugin notification = new FlutterLocalNotificationsPlugin();


void initializeScheduledNotification(){

  var androidNotification = new AndroidInitializationSettings('@mipmap/ic_launcher'); //todo change logo
  // var androidNotification = new AndroidInitializationSettings('icon.png');
  var iosNotification = new IOSInitializationSettings();
  var initialisedSettings = InitializationSettings(android: androidNotification,
      iOS: iosNotification);
  notification = new FlutterLocalNotificationsPlugin();
  notification.initialize(initialisedSettings, onSelectNotification: _onSelect);

}


Future _onSelect(String? payload) async {
  launch(payload ?? "");

}


int _genId(Event event, int day) => (event.location.meetingId.hashCode *10) + day; //day is added to prevent x*0 situations




Future<void> scheduleNotifications(Event event) async{
  var androidDetails = new AndroidNotificationDetails(
    "Where and when scheduled notifications",
    "Scheduled meetings",
    importance: Importance.defaultImportance,
  );
  var iosDetails = new IOSNotificationDetails();
  var genDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);

  initializeTimeZones();

  //iterating through the event's repeat days
  event.days!.forEach((day) async{
    DateTime now = DateTime.now();

    //getting event date in a suitable format
    DateTime date = DateTime(
        now.year,
        now.month,
        day!,
        event.startTime.hour,
        event.startTime.minute);


    // await notification.show(_genId(event, day),
    //     "${event.name} starts now",
    //     (await getTapPreference())
    //         ? "Tap to copy link to Clipboard":"Tap to join meeting",
    //     genDetails);
    //
    //
    //
    notification.zonedSchedule(
        _genId(event,day),
        "${event.name} starts now",
        (await getTapPreference())
            ? "Tap to copy link to Clipboard":"Tap to join meeting",
        TZDateTime.from(date, getLocation("America/Detroit")), //todo dynamic location ?
        genDetails,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: event.location.url
    );

  });


}




///Checks if a notification schedule exists for [event]. Returns TRUE if one exits
///and FALSE if none exists
Future<bool> checkNotifications(Event event) async {
  final List<PendingNotificationRequest> pendingNotifications = await notification.pendingNotificationRequests();
  //generating the id for each event repeat day
  List<int> ids = event.days!.map((e) => _genId(event, e!)).toList();

  //checking if any notification contains a matching id
  PendingNotificationRequest? first = pendingNotifications
      .firstWhereOrNull((element) => ids.contains(element.id));


  return first != null;
}



Future<void> countNotifications() async {
  final List<PendingNotificationRequest> pendingNotifications = await notification.pendingNotificationRequests();
  print("list ${pendingNotifications.length}");
  pendingNotifications.forEach((element) {
    print("${element.id}   \n${element.payload}\n\n\n");
  });

  print("count end");
}



Future<void> deleteNotifications(Event event) async {
    const String channelGroupId = 'your channel group id';
    await notification
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup(channelGroupId);

}


//modify notifications is checking using scheduleNotifications because of the
//current assumption that doing so will overwrite notification ids based on the notification ID
//if it doesn't work, we should delete the other notifications that had that
//ID and schedule new ones
Future<void> modifyNotifications(Event event) async {
  await scheduleNotifications(event);

}