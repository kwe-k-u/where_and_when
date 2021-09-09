import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import "package:flutter/material.dart";


class DurationSelectionWidget extends StatefulWidget {
  final Function(TimeOfDay date) onStartSelected;
  final Function(TimeOfDay date) onEndSelected;
  const DurationSelectionWidget({
    Key? key,
    required this.onStartSelected,
    required this.onEndSelected,
  }) : super(key: key);

  @override
  _DurationSelectionWidgetState createState() => _DurationSelectionWidgetState();
}

class _DurationSelectionWidgetState extends State<DurationSelectionWidget> {
  TimeOfDay? _start;
  TimeOfDay? _end;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        _TimeSelectionButton(
            onTap: (){
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _start ?? TimeOfDay.now(),
                  onChange: (date) {
                    setState(() {
                      widget.onStartSelected(date);
                      _start = date;
                    });
                  },
                ),
              );
            },
          text: "Start Time",
            time: _start
        ),


        Container(
          height: 5,
          width: size.width * 0.08,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12)
          ),
        ),


        _TimeSelectionButton(
            onTap: (){
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _end ?? TimeOfDay.now(),
                  onChange: (date) {
                    setState(() {
                      widget.onEndSelected(date);
                      _end = date;
                    });
                  },
                ),
              );
            },
            text: "End Time",
            time: _end
        ),

      ],
    );
  }
}




class _TimeSelectionButton extends StatefulWidget {
  final void Function() onTap;
  final String text;
  TimeOfDay? time;

  _TimeSelectionButton({
    required this.onTap,
    required this.time,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  __TimeSelectionButtonState createState() => __TimeSelectionButtonState();
}

class __TimeSelectionButtonState extends State<_TimeSelectionButton> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12)
      ),
      width: size.width * 0.4,
      height: size.height * 0.1,
      child: InkWell(
        onTap: widget.onTap,
        child: widget.time == null ?
        Center(
          child: Text(widget.text),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.text),
            Text(widget.time!.format(context))

          ],
        ),
      ),
    );
  }
}
