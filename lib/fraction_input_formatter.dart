import 'package:flutter/services.dart';

class FractionInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    // Allow partial input that could become a valid fraction
    final partialFractionRegex = RegExp(r'^\d*/?\d*$');
    if (partialFractionRegex.hasMatch(text)) {
      return newValue;
    }

    // Check if the input is a valid double
    final doubleRegex = RegExp(r'^\d*\.?\d*$');
    if (doubleRegex.hasMatch(text)) {
      return newValue;
    }

    // If the input is not valid, return the old value
    return oldValue;
  }

  static double parseFraction(String fraction) {
    final parts = fraction.split('/');
    if (parts.length == 2) {
      final numerator = double.tryParse(parts[0]);
      final denominator = double.tryParse(parts[1]);
      if (numerator != null && denominator != null && denominator != 0) {
        return numerator / denominator;
      }
    }
    return double.tryParse(fraction) ?? 0.0;
  }

  static String doubleToFraction(double value) {
    if (value == 0) return '0';
    final denominator = (1 / value).round();
    return '1/$denominator';
  }
}
