

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


  @override
  void initState() {
    super.initState();
    _selectedIndexes = widget.initial;
  }

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: (){
        showModalBottomSheet(
          context: context,
          builder: (context)  {
            return Container(child: Text("test"),);
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

  // String _displayDays(S2MultiSelected<int?>? selected) {
  //   String text = "None selected";
  //
  //   if (selected!= null && selected.value != null){
  //     List<int?> values = selected.value!;
  //
  //   }
  //
  //   return selected.toString();
  // }
}