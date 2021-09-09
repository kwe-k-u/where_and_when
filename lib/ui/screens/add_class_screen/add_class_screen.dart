import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/duration_selection_widget.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/occurance_selection_widget.dart';
import 'package:where_and_when/ui/widgets/custom_text_field.dart';
import 'package:where_and_when/utils/helpers/database.dart';
import 'package:where_and_when/utils/models/event.dart';
import 'package:where_and_when/utils/models/event_location.dart';

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
                    print("start time $time");
                    setState(() {
                      end = time;
                    });
                    },
                    onStartSelected: (time){
                    print("end time $time");
                    setState(() {
                      start = time;
                    });
                    },
                ),
              ),

                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OccurranceSelectionWidget(
                    linkController: link,
                    ),
                    ),


                    SmartSelect<int?>.multiple(
                    title: 'Repeat',
                    selectedValue: _selectedIndexes,
                    onChange: (selected) {
                    setState(() => _selectedIndexes = selected!.value);
                    },
                    choiceType: S2ChoiceType.chips,
                    choiceItems: [
                    S2Choice(value: 0, title: "Monday"),
                  S2Choice(value: 1, title: "Tuesday"),
                  S2Choice(value: 2, title: "Wednesday"),
                  S2Choice(value: 3, title: "Thursday"),
                  S2Choice(value: 4, title: "Friday"),
                  S2Choice(value: 5, title: "Saturday"),
                  S2Choice(value: 6, title: "Sunday"),
                ],
                choiceStyle: S2ChoiceStyle(outlined: true),
                choiceActiveStyle: S2ChoiceStyle(outlined: true),
                modalConfig: S2ModalConfig(
                  type: S2ModalType.bottomSheet,
                  useFilter: true,
                  maxHeightFactor: .7,
                ),
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    value: Text("test"),
                    isTwoLine: true,
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://source.unsplash.com/xsGxhtAsfSA/100x100',
                      ),
                    ),
                  );
                },
              ),


              CustomTextField(
                  label: "Extra notes",
                controller: notes,
              ),

              ElevatedButton(
                  onPressed: () async{
                    Event event = new Event(
                        name: name.text,
                        notes: notes.text,
                        start: start,
                        end: end,
                        location: EventLocation(
                          url: link.text,
                          password: null,
                          meetingId: null
                        ), days: _selectedIndexes,
                    );

                    await uploadEvent(event);
                    // Navigator.pop(context);
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
