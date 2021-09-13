import 'package:flutter/material.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/duration_selection_widget.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/location_selection_widget.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/occurrence_selection_widget.dart';
import 'package:where_and_when/ui/widgets/custom_text_field.dart';
import 'package:where_and_when/utils/helpers/database.dart';
import 'package:where_and_when/utils/models/app_state.dart';
import 'package:where_and_when/utils/models/event.dart';
import 'package:where_and_when/utils/models/event_location.dart';
import 'package:provider/provider.dart';




class AddClassScreen extends StatefulWidget {
  const AddClassScreen({Key? key}) : super(key: key);

  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  List<int?>? _selectedIndexes = [];
  TextEditingController notes = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController link = new TextEditingController();
  TimeOfDay? start;
  TimeOfDay? end;

  @override
  void initState() {
    super.initState();
    _selectedIndexes!.add(DateTime.now().weekday-1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
        leading: BackButton(),
      ),
        body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CustomTextField(
                  label: "Name",
                controller: name,
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DurationSelectionWidget(
                  onEndSelected: (time) {
                    setState(() {
                      end = time;
                    });
                    },
                    onStartSelected: (time){
                    setState(() {
                      start = time;
                    });
                    },
                ),
              ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LocationSelectionWidget(
                        linkController: link,
                      ),
                    ),


                    OccurrenceSelectionWidget(
                      initial: _selectedIndexes,
                      onChange: (selected) {
                        setState(() => _selectedIndexes = selected!.value);
                      }
                    ),


              CustomTextField(
                  label: "Extra notes",
                controller: notes,
              ),

              ElevatedButton(
                  onPressed: () async{

                    if (_selectedIndexes == null || _selectedIndexes!.isEmpty){
                      //todo show snack bar
                    } else {
                      Event event = new Event(
                        name: name.text,
                        notes: notes.text,
                        start: start,
                        end: end,
                        location: EventLocation(
                            url: link.text,
                            password: null,
                            meetingId: null
                        ),
                        days: _selectedIndexes,
                      );

                      await uploadEvent(context.read<AppState>().user,event);
                      context.read<AppState>().addEvent = event;
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text("Save")
              ),


            ],
          ),
        )
        )
    );
  }
}
