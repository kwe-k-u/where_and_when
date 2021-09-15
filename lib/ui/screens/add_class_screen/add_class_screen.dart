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
  final Event? event;
  const AddClassScreen({
    Key? key,
    this.event,
  }) : super(key: key);

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
    if (widget.event == null)
      _selectedIndexes!.add(DateTime.now().weekday-1);
    else{
      _selectedIndexes!.addAll(widget.event!.days ?? []);
      name.text = widget.event!.name;
      notes.text = widget.event!.notes;
      link.text = widget.event!.location.url!;
      end = widget.event!.endTime;
      start = widget.event!.startTime;
    }
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
                  initialEndTime: end,
                  initialStartTime: start,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You have to select at least one repeat day"),
                          backgroundColor: Colors.red,
                        )
                      );
                    } else {
                      Event event = new Event(
                        //todo add reference
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

                      event.reference = await uploadEvent(context.read<AppState>().user,event);

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

  @override
  void dispose() {
    name.dispose();
    notes.dispose();
    super.dispose();
  }
}
