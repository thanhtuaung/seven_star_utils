part of seven_star_utils;

extension ContextExtension on BuildContext {

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> pushNamed<T>(String routeName, {Map<String, dynamic>? arguments}) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  void pop<T>([T? value]) => Navigator.pop<T>(this, value);
}
