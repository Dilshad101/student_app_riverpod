import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.type,
      this.onChanged,
      this.validator});
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final Function(String)? onChanged;
  final FormFieldValidator? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.type,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(widget.label),
      ),
      validator: widget.validator,
    );
  }
}
