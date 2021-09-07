import "package:flutter/material.dart";


class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffix;
  final String label;
  final double? width;
  final EdgeInsets? margin;
  const CustomTextField({
    this.margin,
    this.width,
    this.suffix,
    Key? key,
    this.controller,
    required this.label
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: widget.margin ?? EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: size.width * 0.15,
              child: Text(widget.label,
              maxLines: 2,
              overflow: TextOverflow.fade,
              )
          ),

          SizedBox(
            width: widget.width ?? size.width * 0.8,
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: widget.suffix
              ),
            ),
          ),
        ],
      ),
    );
  }
}
