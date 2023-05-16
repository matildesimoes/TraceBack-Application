import 'package:flutter_test/flutter_test.dart';
import 'package:TraceBack/authentication/signup_validators.dart';

void main() {
  group('nameValidator', () {
    test('returns null if value is not empty', () {
      expect(nameValidator.validate('John'), null);
    });

    test('returns an error message if value is empty', () {
      expect(nameValidator.validate(''), 'Please enter a name');
    });
  });

  group('emailValidator', () {
    test('returns null if value is a valid UP email address', () {
      expect(emailValidator.validate('up12345@up.pt'), null);
    });

    test('returns an error message if value is not a valid UP email address', () {
      expect(emailValidator.validate('john@gmail.com'), 'Please enter a valid UP email address');
    });

    test('returns an error message if value is empty', () {
      expect(emailValidator.validate(''), 'Please enter an UP email address');
    });
  });

  group('phoneValidator', () {
    test('returns null if value is a valid phone number', () {
      expect(phoneValidator.validate('912345678'), null);
    });

    test('returns an error message if value is not a valid phone number', () {
      expect(phoneValidator.validate('ght'), 'Please enter a valid phone number');
    });

    test('returns an error message if value is empty', () {
      expect(phoneValidator.validate(''), 'Please enter a phone number');
    });
  });

  group('passwordValidator', () {
    /*test('returns null if value is a valid password', () {
      expect(passwordValidator.validate('Abc6789'), null);
    });*/

    test('returns an error message if value is too short', () {
      expect(passwordValidator.validate('Abc123'), 'Password must be at least 8 characters long');
    });

    test('returns an error message if value does not contain a lowercase letter', () {
      expect(passwordValidator.validate('ABC12345'), 'Password must contain at least one lowercase letter');
    });

    test('returns an error message if value does not contain an uppercase letter', () {
      expect(passwordValidator.validate('abc12345'), 'Password must contain at least one uppercase letter');
    });

    test('returns an error message if value does not contain a digit', () {
      expect(passwordValidator.validate('Abcdefgh'), 'Password must contain at least one digit');
    });

    test('returns an error message if value is empty', () {
      expect(passwordValidator.validate(''), 'Password is required');
    });
  });
}

