import 'package:flutter/material.dart';
import 'package:break_balance/views/widgets/note_text.dart';

import 'boolean_editing_controller.dart';

class SwitchField extends StatefulWidget {
  final BooleanEditingController controller;
  final Function(bool) onChanged;
  final String text;
  final EdgeInsetsGeometry padding;

  SwitchField({this.controller, this.onChanged, this.text, this.padding});

  @override
  _SwitchFieldState createState() => _SwitchFieldState();
}

class _SwitchFieldState extends State<SwitchField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: widget.padding,
          child: NoteText(widget.text),
        )),
        Container(
          padding: widget.padding,
          child: Switch(
              value: widget.controller.value,
              onChanged: (value) {
                widget.controller.value = value;
                if (widget.onChanged != null) {
                  widget.onChanged(value);
                }
                setState(() {});
              }),
        )
      ],
    );
  }
}
