import 'package:get/get.dart';

mixin ValidationsMixin {
  static String? _storedPassword;

  String? validatedPhoneNumber(String? value) {
    if (value == null ||
        value.length > 10 ||
        value.isEmpty ||
        value.length < 10) {
      return 'Please enter valid phone number';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'Please enter valid phone number';
    } else {
      return null;
    }
  }

  String? validatedName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid name';
    } else {
      return null;
    }
  }

  String? validatedMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid message';
    } else {
      return null;
    }
  }

  String? validatedAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid address';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email address';
    }
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    _storedPassword = password;
    if (_storedPassword == null || _storedPassword!.isEmpty) {
      return 'Please enter a valid password';
    }
    return null;
  }

  String? matchPasswords(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter a valid password';
    }
    if (_storedPassword != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateTask(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter a task more than 4 characters';
    }
    return null;
  }

  String? validateOTPCode(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter a valid code';
    }
    return null;
  }

  String? validPhoneNumber(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length > 10 ||
        value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validOtp(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length > 6 ||
        value.length < 6) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
