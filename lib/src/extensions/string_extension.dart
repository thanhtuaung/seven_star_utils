part of seven_star_utils;

extension StringExtension on String {
  String get toCapitalize => replaceFirst(this[0], this[0].toUpperCase());

  bool get isEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  String? get isStrongPassword {
    if (length < 6) {
      return "Password length must be grater than 6";
    }
    if (contains("@")) {
      return "Password must contain @ sign";
    }
    return null;
  }
}
