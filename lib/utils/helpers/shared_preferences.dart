


import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_and_when/utils/constants.dart';

///Returns a boolean to signify if the user wants tapping on an event
///tile to copy the url to the clipboard or to launch the meeting in zom
/// A value of TRUE implies copy to clipboard while FALSE implies launch meeting in zoom
Future<bool> getTapPreference() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool value = pref.getBool(SHARED_PREF_TAP_TO_COPY) ?? false;
  return value;
}


///Sets a boolean to signify if the user wants tapping on an event
///tile to copy the url to the clipboard or to launch the meeting in zoom
/// A value of TRUE implies copy to clipboard while FALSE implies launch meeting in zoom
Future <void> setTapPreference(bool value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.setBool(SHARED_PREF_TAP_TO_COPY, value);
}