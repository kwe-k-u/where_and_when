

import "package:flutter/material.dart";


class OccurrenceSelectionWidget extends StatefulWidget {

  final List<int> initial;
  final void Function(dynamic)? onChange;
  OccurrenceSelectionWidget({
    required this.initial,
    required this.onChange,
    Key? key
  }) : super(key: key);

  @override
  _OccurrenceSelectionWidgetState createState() => _OccurrenceSelectionWidgetState();
}

class _OccurrenceSelectionWidgetState extends State<OccurrenceSelectionWidget> {

  List<int> _selectedIndexes = [];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];


  @override
  void initState() {
    super.initState();
    _selectedIndexes = widget.initial;
  }



  List<ChoiceChip> _genOptions(){
    List<ChoiceChip> widgets = [];
    for (int index = 0; index < days.length; index++){
      widgets.add(ChoiceChip(
          label: Text(days[index]),
          selected: _selectedIndexes.contains(index),
        selectedColor: Colors.blue,
        onSelected: (selected){
              Set<int> set = _selectedIndexes.toSet();
              if (selected){ // add day to selected indexes
                set.add(index);
              } else { // remove day from selected indexes
                set.remove(index);
              }
              setState(() {
                _selectedIndexes = set.toList();
              });

            print(_selectedIndexes);
        },
      ));
    }

    return widgets;
  }



  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Selected days"),
      subtitle: Text(_displayDays()),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              bool _mon = false;
              return Wrap(
                children: _genOptions(),
              );
            }
        );
      },
    );


    // return SmartSelect<int?>.multiple(
    //   title: 'Repeat',
    //   selectedValue: _selectedIndexes,
    //   onChange: widget.onChange,
    //   choiceType: S2ChoiceType.chips,
    //   choiceItems: [
    //     S2Choice(value: 0, title: "Monday"),
    //     S2Choice(value: 1, title: "Tuesday"),
    //     S2Choice(value: 2, title: "Wednesday"),
    //     S2Choice(value: 3, title: "Thursday"),
    //     S2Choice(value: 4, title: "Friday"),
    //     S2Choice(value: 5, title: "Saturday"),
    //     S2Choice(value: 6, title: "Sunday"),
    //   ],
    //   choiceStyle: S2ChoiceStyle(outlined: true),
    //   choiceActiveStyle: S2ChoiceStyle(outlined: true),
    //   modalConfig: S2ModalConfig(
    //     type: S2ModalType.bottomSheet,
    //     useFilter: true,
    //     maxHeightFactor: .7,
    //   ),
    //   tileBuilder: (context, state) {
    //     return S2Tile.fromState(
    //       state,
    //       value: Text(_displayDays(state.selected)),
    //       isTwoLine: true,
    //       leading: CircleAvatar(child: Icon(Icons.repeat)),
    //     );
    //   },
    // );
  }

  String _displayDays() {
    if (_selectedIndexes.isEmpty){
      return "None selected";
    }
    String text = "";
    _selectedIndexes.forEach((element) {text += "${days[element]} ";});


    return text.trim();
  }
}

