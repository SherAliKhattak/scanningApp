// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scanningapp/components/favorite_list_view_builder.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import '../../utilis/convert_to_pdf_utils.dart';

class FavouritesScreen extends StatefulWidget {
  static const String id = 'FavouritesScreen.id';
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translation(context).favorites,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: GetBuilder<PDFController>(builder: (controller) {
                      return Column(
                        children: [
                          SizedBox(
                            width: Get.width * 0.89,
                            child: TextField(
                              controller: controller.favoritesSearchController,
                              onChanged: (value) {
                                Utils.searchFavoritePDF(value);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Theme.of(context).cardColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 15,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                hintText: translation(context).search,
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w200,
                                  color: Theme.of(context).hintColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).cardColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            PDFController.instance.favoriteFiles.isNotEmpty
                ? Flexible(
                    child: GetBuilder<PDFController>(builder: (pdf) {
                      return ListView.builder(
                        itemCount: pdf.searchFavoriteFile.length,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          var file = pdf.favoriteFiles.elementAt(index);
                          return FavoritesListviewBuilder(
                            file: file,
                          );
                        },
                      );
                    }),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: Get.height / 1.4,
                        child: const Center(
                          child: Text('No Favorite Files To show'),
                        ),
                      ),
                    ],
                  )
          ],
        ));
  }
}
