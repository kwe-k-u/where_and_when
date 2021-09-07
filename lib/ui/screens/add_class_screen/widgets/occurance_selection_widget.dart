import "package:flutter/material.dart";
import 'package:where_and_when/ui/widgets/custom_text_field.dart';


class OccurranceSelectionWidget extends StatefulWidget {
  const OccurranceSelectionWidget({Key? key}) : super(key: key);

  @override
  _OccurranceSelectionWidgetState createState() => _OccurranceSelectionWidgetState();
}

class _OccurranceSelectionWidgetState extends State<OccurranceSelectionWidget> {
  String _value = "in-person";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: DropdownButtonFormField(
              onChanged: (String? value){
                if (value != null)
                setState(() {
                  _value = value;
                });
              },
              items: [
                DropdownMenuItem(child: Text("ONLINE"), value: "online",),
                DropdownMenuItem(child: Text("IN-PERSON"), value: "in-person",)
              ],
              value: _value,
            ),
          ),

          Spacer(),
          SizedBox(
              width: size.width * 0.6,

              child: _Selection(current: _value))



      ]
      ),
    );
  }
}






class _Selection extends StatefulWidget {
  String current;
  _Selection({
    required this.current,
    Key? key
  }) : super(key: key);

  @override
  __SelectionState createState() => __SelectionState();
}

class __SelectionState extends State<_Selection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (widget.current != "in-person")
      return CustomTextField(
        width: size.width * 0.4,
          label: "Link",
      );
      return Row(
        children: [
          CustomTextField(
              width: size.width * 0.4,
          label: "Location",
            suffix: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.location_on),
            )
          ),

        ],
      );
  }
}

