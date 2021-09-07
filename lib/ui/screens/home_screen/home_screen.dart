

import 'package:flutter/material.dart';
import 'package:where_and_when/ui/screens/add_class_screen/add_class_screen.dart';
import 'package:where_and_when/ui/screens/home_screen/widgets/custom_drawer.dart';
import 'package:where_and_when/ui/screens/home_screen/widgets/schedule_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();
  int initialIndex = 0; //index for the day that today is

  @override
  void initState() {
    super.initState();

    initialIndex = today.weekday;
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        initialIndex: initialIndex-1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Good morning Kweku,"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text("Mon"),
                ),
                Tab(
                  child: Text("Tue"),
                ),
                Tab(
                  child: Text("Wed"),
                ),
                Tab(
                  child: Text("Thurs"),
                ),
                Tab(
                  child: Text("Fri"),
                ),
                Tab(
                  child: Text("Sat"),
                ),
                Tab(
                  child: Text("Sun"),
                ),
              ],
            ),
          ),

          drawer: CustomDrawer(),

          body: TabBarView(
            children: [

              ScheduleView(),
              ScheduleView(),
              ScheduleView(),
              ScheduleView(),
              ScheduleView(),
              ScheduleView(),
              ScheduleView(),

            ],
          ),


          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> AddClassScreen()
                  )
              );
            },
          ),
        )
    );
  }
}
