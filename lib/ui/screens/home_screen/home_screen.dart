

import 'package:flutter/material.dart';
import 'package:where_and_when/ui/screens/add_class_screen/add_class_screen.dart';
import 'package:where_and_when/ui/screens/home_screen/widgets/custom_drawer.dart';
import 'package:where_and_when/ui/screens/home_screen/widgets/schedule_view.dart';
import 'package:where_and_when/utils/helpers/database.dart';
import 'package:where_and_when/utils/models/app_state.dart';
import 'package:provider/provider.dart';
import 'package:where_and_when/utils/models/event.dart';



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

    return FutureBuilder(
        future: getEvents(context.read<AppState>().user),
        builder: (context, snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done){
            context.read<AppState>().addAllEvents = snapshot.data as List<Event>;
            return  DefaultTabController(
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

                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(0),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(1),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(2),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(3),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(4),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(5),
                      ),
                      ScheduleView(
                        events: context.read<AppState>().getEventsByDay(6),
                      ),

                    ],
                  ),


                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AddClassScreen()
                          )
                      ).then((value) {
                        if (value)
                          setState(() {

                          });
                      });
                    },
                  ),
                )
            );
          }
          else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
    );
  }
}
