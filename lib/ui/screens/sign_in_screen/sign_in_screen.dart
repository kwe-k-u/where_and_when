import 'package:flutter/material.dart';
import 'package:where_and_when/ui/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:where_and_when/utils/helpers/auth.dart';
import 'package:where_and_when/utils/models/app_state.dart';
import 'package:where_and_when/Yodo1Mas.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key){
    Yodo1Mas.instance.init("Your app key", (successful) {

    });
  }



  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {Yodo1Mas.instance.init("Your app key", (successful) {

  });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed: (){
                  signIn().then((value) {
                    if (value != null){
                      context.read<AppState>().user = value;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> HomeScreen()
                          )
                      );
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Couldn't Sign in. Try Again!"))
                      );
                    }
                  });
                },
                child: Text("Sign In with Google"))

          ],
        ),
      ),
    );
  }
}
