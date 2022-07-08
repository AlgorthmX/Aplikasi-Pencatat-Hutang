import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? initialValue;
  final bool isDate;
  final VoidCallback? onSuffixClick;
  final int maxLines;
  final TextInputType? textInputType;
  final Function(String?)? onSaved;
  final bool isNullable;
  const CustomInput({
    Key? key,
    this.controller,
    this.initialValue,
    this.isDate = false,
    this.onSuffixClick,
    this.maxLines = 1,
    this.textInputType,
    this.onSaved,
    this.isNullable = false,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      style: const TextStyle(fontSize: 18),
      readOnly: isDate,
      keyboardType: textInputType,
      onSaved: onSaved,
      validator: (value) {
        if (isNullable) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return 'Tidak boleh kosong';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        focusColor: Colors.blueAccent,
        suffixIcon: isDate
            ? IconButton(
                icon: Icon(Icons.date_range),
                onPressed: onSuffixClick,
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
