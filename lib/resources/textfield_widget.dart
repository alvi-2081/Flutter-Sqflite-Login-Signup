import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintName;
  final IconData? icon;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;
  final FormFieldValidator? validator;

  const TextFieldWidget(
      {super.key,
      this.controller,
      this.hintName,
      this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.validator,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
