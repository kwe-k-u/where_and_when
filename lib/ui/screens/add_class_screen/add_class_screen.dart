import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/duration_selection_widget.dart';
import 'package:where_and_when/ui/screens/add_class_screen/widgets/occurance_selection_widget.dart';
import 'package:where_and_when/ui/widgets/custom_text_field.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({Key? key}) : super(key: key);

  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  List<int?>? _selectedIndexes = [];
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
                  label: "Name"
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DurationSelectionWidget(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OccurranceSelectionWidget(),
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
                  label: "Extra notes"
              ),

              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Save")
              )

            ],
          ),
        )
        )
    );
  }
}
