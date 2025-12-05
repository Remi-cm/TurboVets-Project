
import 'package:flutter/material.dart';

import '../services/local_database.dart';


class GlobalProvider extends ChangeNotifier {

  bool themeIsDark;

  GlobalProvider({required this.themeIsDark});
  
  bool get isDark => themeIsDark;
  
  void setTheme(bool val) async {
    await LocalDatabase().setTheme(val);
    themeIsDark = val;
    notifyListeners();
  }

}