import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.myFocusNode,this.keyboardType,this.labelText,this.onChange,this.obscureText});

  final FocusNode myFocusNode;
  final TextInputType keyboardType;
  final String labelText;
  final Function onChange;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChange,
        keyboardType: keyboardType,
        decoration: InputDecoration (
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)), labelText: labelText,labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.black
        ),),
      ),
    );
  }
}
