import 'package:flutter/material.dart';


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
                  child: CircleAvatar(),
                ),
                Text("User's name")
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
