import 'package:flutter/material.dart';
import 'package:break_balance/views/widgets/note_text.dart';

import 'boolean_editing_controller.dart';

class CheckboxField extends StatefulWidget {
  final BooleanEditingController controller;
  final Function(bool) onChanged;
  final String text;
  final EdgeInsetsGeometry padding;

  CheckboxField({this.controller, this.onChanged, this.text, this.padding});

  @override
  _CheckboxFieldState createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
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
          child: Checkbox(
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
