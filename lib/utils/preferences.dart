import 'package:shared_preferences/shared_preferences.dart';

/*
 * https://gist.github.com/faisalraja/9b628439978c67b2fb6515cf202a3992
 */
class Preferences {
  final SharedPreferences _prefs;

  Preferences._(this._prefs);

  static Future<Preferences> create(SharedPreferences sharedPreferences) async {
    Preferences preferences = Preferences._(sharedPreferences);
    return preferences;
  }
  Map<String, dynamic> _memoryPrefs = Map<String, dynamic>();

  static const String KEY_SETTINGS_THEME = "settings_theme";
  static const String KEY_SETTINGS_SHOW_NSFW = "settings_show_nsfw";
  static const String KEY_SETTINGS_BIOMETRIC_LOCK = "settings_biometric_lock";
  static const String KEY_FAVORITE_BOARDS = "favorite_boards";
  static const String KEY_THREAD_CATALOG_MODE = "thread_catalog_mode";
  static const String KEY_NEXT_POST_ID = "next_post_id";
  static const String KEY_NEXT_THREAD_ID = "next_thread_id";
  static const String KEY_PLAYER_VOLUME = "player_volume";

  void onAppResumed() {
    setDouble(KEY_PLAYER_VOLUME, 0.0);
  }

  void setStringList(String key, List<String> value) {
    _prefs.setStringList(key, value);
    _memoryPrefs[key] = value;
  }

  void setString(String key, String value) {
    _prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  void setInt(String key, int value) {
    _prefs.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  void setBool(String key, bool value) {
    _prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  List<String> getStringList(String key) {
    List<String>? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getStringList(key);
    }
    if (val == null) {
      val = [];
    }
    _memoryPrefs[key] = val;
    return val;
  }

  String getString(String key, {String? def}) {
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getString(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val!;
  }

  int getIntDef(String key, int def) {
    int? val = getInt(key);
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  int? getInt(String key) {
    int? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getInt(key);
    }
    _memoryPrefs[key] = val;
    return val;
  }

  double getDouble(String key, {double? def}) {
    double? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getDouble(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val!;
  }

  bool getBool(String key, {bool def = false}) {
    bool? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getBool(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }
}
