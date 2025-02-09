// filepath: /home/jpfelgueiras/sunny16/test/fraction_input_formatter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sunny16/fraction_input_formatter.dart';

void main() {
  group('FractionInputFormatter Tests', () {
    test('formatEditUpdate allows valid fraction input', () {
      final formatter = FractionInputFormatter();
      final oldValue = TextEditingValue(text: '');
      final newValue = TextEditingValue(text: '1/2');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1/2');
    });

    test('formatEditUpdate allows valid double input', () {
      final formatter = FractionInputFormatter();
      final oldValue = TextEditingValue(text: '');
      final newValue = TextEditingValue(text: '1.5');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1.5');
    });

    test('formatEditUpdate rejects invalid input', () {
      final formatter = FractionInputFormatter();
      final oldValue = TextEditingValue(text: '1/2');
      final newValue = TextEditingValue(text: '1/2a');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1/2');
    });

    test('parseFraction parses valid fraction correctly', () {
      final result = FractionInputFormatter.parseFraction('1/2');

      expect(result, 0.5);
    });

    test('parseFraction parses valid double correctly', () {
      final result = FractionInputFormatter.parseFraction('1.5');

      expect(result, 1.5);
    });

    test('parseFraction returns 0.0 for invalid input', () {
      final result = FractionInputFormatter.parseFraction('invalid');

      expect(result, 0.0);
    });

    test('doubleToFraction converts double to fraction correctly', () {
      final result = FractionInputFormatter.doubleToFraction(0.5);

      expect(result, '1/2');
    });

    test('doubleToFraction returns "0" for 0.0 input', () {
      final result = FractionInputFormatter.doubleToFraction(0.0);

      expect(result, '0');
    });
  });
}
