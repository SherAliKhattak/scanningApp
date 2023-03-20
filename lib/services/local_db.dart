import 'dart:developer';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices {
  saveFavoritesList(
    List<String> path,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setStringList('favorites', path);

    log('The list is saved');
  }

  getFavoritesList() async {
    var controller = PDFController.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> result = preferences.getStringList('favorites')!;

    controller.favoriteFiles.addAll(result);

    log('$result got the result');
  }

  setDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setBool('isDark', value);
    log('$value is saved');
  }

  Future<bool> getDarkmode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark')!;
    log('$isDark is received');
    return isDark;
  }

  // setFileName({String? docnameController}) async {
  //   var controller = PDFController.instance;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('filename', docnameController!);
  // }

  // getFileName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String result = prefs.getString('filename')!;
  //   log(result);

  //   return result;
  // }

  // deleteFavoritesList() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.remove('favorites');
  // }
}
