import 'package:flutter/material.dart';
import 'package:where_and_when/utils/models/app_state.dart';
import 'package:provider/provider.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
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
                Text(context.read<AppState>().user.displayName ?? context.read<AppState>().user.email!.split("@")[0])
              ],
            ),
          ),

          ListTile(
            title: Text("Profile"),
          ),

          ListTile(
            title: Text("Sync with"),
          ),

          ListTile(
            title: Text("Log out"),
          ),
        ],
      ),
    );
  }
}
