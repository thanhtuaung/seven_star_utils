part of seven_star_utils;

class SevenStarUtils {
  static final SevenStarUtils _instance = SevenStarUtils._();
  static BuildContext? _appContext;

  SevenStarUtils._();

  factory SevenStarUtils() {
    return _instance;
  }

  static setAppContext(BuildContext context) {
    _appContext = context;
  }

  static get appContext => _appContext;
}
