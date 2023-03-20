import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PDFController extends GetxController {
  late TextEditingController fileName;
  late TextEditingController renameController;
  late TextEditingController passwordController;
/////////////////////////////////////////////
  late TextEditingController searchController;
  final searchFiles = <FileSystemEntity>[].obs;
  final files = <FileSystemEntity>[].obs;
/////////////////////////////////////////////////
  late TextEditingController favoritesSearchController;
  final favoriteFiles = <String>[].obs;
  final searchFavoriteFile = <String>[].obs;
  @override
  void onInit() {
    passwordController = TextEditingController();
    renameController = TextEditingController();
    fileName = TextEditingController();
    favoritesSearchController = TextEditingController();
    searchController = TextEditingController();
    searchFiles.value = files;
    searchFavoriteFile.value = favoriteFiles;
    // });
    super.onInit();
  }

  // bool updateIsLiked(bool state) {
  //   isLiked = state;
  //   update();
  //   return state;
  // }

  static PDFController get instance => Get.put(PDFController());
}
