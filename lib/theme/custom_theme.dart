import 'package:flutter/material.dart';

const _colorBlack = Color(0xFF223943);
const _colorGrey = Color(0xFF64666C);
const _primaryColor = Color(0xFF266EF1);
const _semanticRed = Color(0xFFFF3835);
const _semanticGreen = Color(0xFF00993C);

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: _colorBlack, fontSize: 24, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: _colorBlack),
          bodyText1: TextStyle(
              color: _colorGrey, fontSize: 16, fontWeight: FontWeight.normal),
          bodyText2: TextStyle(
              color: _colorGrey, fontSize: 12, fontWeight: FontWeight.normal),
          button: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        errorColor: _semanticRed,
        highlightColor: _semanticGreen,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(circularTrackColor: Colors.white),
        primaryColor: _primaryColor,
        secondaryHeaderColor: _colorBlack,
        scaffoldBackgroundColor: Colors.white);
  }
}
