abstract class FieldValidator {
  String? validate(String? value);
}
class EmailValidator extends FieldValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }
}

class PasswordValidator extends FieldValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    final letterRegex = RegExp(r'[A-Za-z]');
    if (!letterRegex.hasMatch(value)) return 'Password must contain at least one letter';
    return null;
  }
}

class EgyptianPhoneValidator extends FieldValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    final egyptPhoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');
    if (!egyptPhoneRegex.hasMatch(value)) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }
}