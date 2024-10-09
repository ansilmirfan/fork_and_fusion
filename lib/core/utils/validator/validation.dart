// ignore_for_file: body_might_complete_normally_nullable

class Validation {
  //-------email validation------------
  static String? validateEmail(String? email) {
    if (email != null) {
      if (email.isEmpty) {
        return 'Email address cannot be empty';
      }
      final RegExp emailRegExp = RegExp(
        r'^([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$',
        caseSensitive: false,
        multiLine: false,
      );
      if (!emailRegExp.hasMatch(email)) {
        return 'Invalid email address';
      } 
    }
  }

  static String? passwordValidation(String? word) {
      const int minLength = 5;
    if (word != null) {
      if (word.isEmpty) {
        return 'Password cannot be empty';
      }  else if (word.length < minLength) {
        return 'password must be at least $minLength characters long';
      }
    
    }
  }

  static String? validateName(String? name) {
    const int minLength = 5;
    if (name != null) {
      if (name.isEmpty) {
        return 'Name cannot be empty';
      } else if (name.length < minLength) {
        return 'Name must be at least $minLength characters long';
      }
    }

 
  }
}
