import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText,labelText,valueKey;
  final Function onSaved,validate;
  final bool isObscure;
final textType;
  CustomTextFormField({this.valueKey,this.isObscure,this.textType,this.validate,this.hintText, this.labelText, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: ValueKey(valueKey),
        obscureText: isObscure,
        keyboardType: textType,
validator: validate,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,


        ),
      ),
    );
  }
}
