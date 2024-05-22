

import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration build(BuildContext context,String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}