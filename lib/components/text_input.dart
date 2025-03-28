import 'package:flutter/material.dart';

class TextInputComponents extends StatefulWidget {
  const TextInputComponents({
    super.key,
    this.valueChanged,
    this.hintText,
    required this.controller,
  });

  final String? hintText;

  final ValueChanged<String>? valueChanged;

  final TextEditingController controller;

  @override
  State<TextInputComponents> createState() => _TextInputComponentsState();
}

class _TextInputComponentsState extends State<TextInputComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        cursorRadius: Radius.circular(0),
        controller: widget.controller,
        onChanged: (value) {
          widget.valueChanged!(value);
        },
      ),
    );
  }
}
