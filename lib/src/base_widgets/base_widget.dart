part of seven_star_utils;

mixin BaseWidget {
  String? appBarTitle() {
    return null;
  }

  List<Widget>? appBarActions() {
    return null;
  }

  Widget body(BuildContext context);

  EdgeInsets appPadding() {
    return EdgeInsets.all(ConstantDimensions.pagePadding);
  }

  List<Widget>? persistentButtons() {
    return null;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  void init() {}
}
