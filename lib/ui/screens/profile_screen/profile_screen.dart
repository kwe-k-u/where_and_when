

import 'package:flutter/material.dart';
import 'package:where_and_when/utils/helpers/shared_preferences.dart';
import 'package:where_and_when/utils/models/app_state.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _onTap = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getTapPreference().then((value) => _onTap = value);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
        body: Container(width: size.width,
        height: size.height,
        child: Column(
          children: [

            SizedBox(
              height: size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(context.read<AppState>().user.photoURL!),
                  ),
                  Text(context.read<AppState>().user.displayName ?? context.read<AppState>().user.email!.split("@")[0]),


                ],
              ),
            ),

            Text("Settings"),
            SwitchListTile(
                title: Text("Tap to copy class details"),
                subtitle: Text(_onTap ? "Current setting will copy to clipboard when tapped."
                    : "Current setting will launch meeting url when tapped."),
                value: _onTap,
                onChanged: (value) async{
                  await setTapPreference(value);
                  setState(() {
                    _onTap = value;
                  });
                })
          ],
        )
        )
    );
  }
}
