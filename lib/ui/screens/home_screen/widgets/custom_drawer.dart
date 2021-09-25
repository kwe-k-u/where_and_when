import 'package:flutter/material.dart';
import 'package:where_and_when/ui/screens/profile_screen/profile_screen.dart';
import 'package:where_and_when/utils/helpers/auth.dart';
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
                  child: Image.network(
                      context.read<AppState>().user.photoURL!,
                    loadingBuilder: (context, widget, chunk) {
                        return Icon(Icons.image);
                    },
                  ),
                ),
                Text(context.read<AppState>().user.displayName ?? context.read<AppState>().user.email!.split("@")[0])
              ],
            ),
          ),

          ListTile(
            title: Text("Profile"),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> ProfileScreen()
                  )
              );
            },
          ),

          ListTile(
            title: Text("Sync with"),
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("To be implemented Soon!")
                )
              );
              // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text("Awaiting implementation"),
              //     actions: [TextButton(child: Text("Okay"), onPressed: (){},)])
              // );
            },
          ),

          ListTile(
            title: Text("Log out"),
            onTap: (){
              signOut().then(
                      (value) => context.read<AppState>().user = null
              );
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
