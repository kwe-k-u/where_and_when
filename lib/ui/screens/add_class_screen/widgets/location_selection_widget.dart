import "package:flutter/material.dart";
import 'package:where_and_when/ui/widgets/custom_text_field.dart';


class LocationSelectionWidget extends StatefulWidget {
  final TextEditingController? linkController;

  const LocationSelectionWidget({
    Key? key,
    this.linkController
  }) : super(key: key);

  @override
  _LocationSelectionWidgetState createState() => _LocationSelectionWidgetState();
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {
  String _value = "online";
  // String _value = "in-person";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          // SizedBox(
          //   width: size.width * 0.3,
          //   child: DropdownButtonFormField(
          //     onChanged: (String? value){
          //       if (value != null)
          //       setState(() {
          //         _value = value;
          //       });
          //     },
          //     items: [
          //       DropdownMenuItem(child: Text("ONLINE"), value: "online",),
          //       DropdownMenuItem(child: Text("IN-PERSON"), value: "in-person",)
          //     ],
          //     value: _value,
          //   ),
          // ),
          //
          // Spacer(),
          SizedBox(
              width: size.width * 0.6,

              child: _Selection(
                  current: _value,
                linkController: widget.linkController,
              )
          )



      ]
      ),
    );
  }
}






class _Selection extends StatefulWidget {
  final String current;
  final TextEditingController? linkController;

  _Selection({
    required this.current,
    this.linkController,
    Key? key
  }) : super(key: key);

  @override
  __SelectionState createState() => __SelectionState();
}

class __SelectionState extends State<_Selection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if (widget.current != "in-person")
      return CustomTextField(
        width: size.width * 0.4,
          label: "Meeting Url",
        controller: widget.linkController,
      );
      // return Row(
      //   children: [
      //     CustomTextField(
      //         width: size.width * 0.4,
      //     label: "Location",
      //       suffix: IconButton(
      //         onPressed: (){
      //
      //         },
      //         icon: Icon(Icons.location_on),
      //       )
      //     ),
      //
      //   ],
      // );
  }
}

