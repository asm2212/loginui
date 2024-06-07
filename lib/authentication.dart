// authentication.dart

class Authentication {
  static List<String> _usernames = ["username"];
  static List<String> _passwords = ["password123"];

  static bool fetchCredentials(String username, String password) {
    for (var j = 0; j < _usernames.length; j++) {
      if (username == _usernames[j] && password == _passwords[j]) {
        return true;
      }
    }
    return false;
  }

  static bool checkUserRepeat(String username) {
    return _usernames.contains(username);
  }

  static void insertCredentials(String username, String password) {
    _usernames.add(username);
    _passwords.add(password);
  }

  static bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &&
        hasUppercase &&
        hasLowercase &&
        hasSpecialCharacters &&
        hasMinLength;
  }
}
