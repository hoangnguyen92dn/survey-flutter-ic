import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/extension/string_extension.dart';

void main() {
  group('StringExtension', () {
    setUp(() {});

    test('When string does not contain @ character, it returns False', () {
      expect("email".isValidEmail(), false);
    });

    test('When string does not contain domain, it returns False', () {
      expect("email@".isValidEmail(), false);
    });

    test('When string does not valid contain, it returns False', () {
      expect("email@example".isValidEmail(), false);
    });

    test('When string is valid email, it returns True', () {
      expect("email@example.com".isValidEmail(), true);
    });
  });
}
