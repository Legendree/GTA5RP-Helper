import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({@required this.hintText, this.isObscure = false, @required this.onChanged, this.keyboardType});
  final String hintText;
  final bool isObscure;
  final Function onChanged;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color(0xFF212121),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: TextField(
            obscureText: isObscure,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: hintText,
                //removes the underline of TextField!
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff686868)),
                border: InputBorder.none),
            style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
            maxLines: 1,
            onChanged: onChanged,
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }
}
