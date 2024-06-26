import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormfield extends StatelessWidget {
  CustomTextFormfield(
      {Key? key, this.hintText, this.onChanged, this.obscure = false})
      : super(key: key);

  String? hintText;

  bool? obscure;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      validator: (data) {
        if (data!.isEmpty) {
          return ('Field is Required');
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
