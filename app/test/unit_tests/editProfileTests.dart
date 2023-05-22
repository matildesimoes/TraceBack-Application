import 'package:TraceBack/profile/editprofile.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('nameValidator', () {
    test('should return null if the value is not empty and correct', () {
      final result = nameValidator.validate('John Doe');
      expect(result, null);
    });

    test('should return an error message if the value is empty', () {
      final result = nameValidator.validate('');
      expect(result, 'Please enter a name');
    });
  });

  group('phoneValidator', () {
    test('should return null if the value is not empty and correct', () {
      final result = phoneValidator.validate('912345678');
      expect(result, null);
    });

    test('should return an error message if the value is empty', () {
      final result = phoneValidator.validate('');
      expect(result, 'Please enter a phone number');
    });

    test('should return an error message if the value is wrong', () {
      final result = phoneValidator.validate('9123hgy456');
      expect(result, 'Please enter a valid phone number');
    });
  });
}