import 'package:hive_ce/hive.dart';

const String  themeBoxDB = "THEME";
const String isDarkKey = 'IS_DARK';
const String darkTheme = "DARK_THEME";
const String lightTheme = "LIGHT_THEME";

class LocalDatabase {

  setTheme(bool val) async {
    Box themeBox = await Hive.openBox(themeBoxDB);
    themeBox.put(isDarkKey, val);
  }

  Future<bool> getTheme() async {
    Box themeBox = await Hive.openBox(themeBoxDB);
    return themeBox.get(isDarkKey) ?? false;
  }

}