import 'package:flowerdecorations/config/styling.dart';
import 'package:flutter/material.dart';

///InputDecoration for TextFormField used in Project
InputDecoration textInputDecoration = const InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: ProjectColors.formFieldBordersActive,
      width: 2.0,
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.zero,
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: ProjectColors.formFieldBordersFocused,
    width: 3.0,
  )),
);
