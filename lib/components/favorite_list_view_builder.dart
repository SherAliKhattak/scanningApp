import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanningapp/components/flutter_toast.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/services/local_db.dart';

import '../controllers/pdf_controller.dart';
import '../utilis/convert_to_pdf_utils.dart';
import 'document_listview_item.dart';
// import 'package:open_filex/open_filex.dart';

class FavoritesListviewBuilder extends StatelessWidget {
  final String? file;
  const FavoritesListviewBuilder({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0, left: 5, right: 5),
      child: InkWell(
        onTap: () {
          // log('message');
          // OpenFilex.open(widget.files!.path);
        },
        child: Container(
          height: Get.height * 0.11,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 0.0, left: 10.0, top: 5.0, bottom: 5.0),
                child: SizedBox(
                  height: Get.height * 0.081,
                  width: Get.width * 0.18,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: const Image(
                      fit: BoxFit.fill,
                      image: AssetImage('images/sodapdf-converted.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file!.split('/').last.toString(),
                      style: GoogleFonts.nunito(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 0.018,
                              width: 0.025,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: const Color(0xff4b5770)),
                              child: Center(
                                  child: Text(
                                '1',
                                style: GoogleFonts.nunito(
                                    color: Colors.white, fontSize: 14),
                              )),
                            ),
                          ),
                          Text(
                            '09/12/2022  08:18     255kb',
                            style: GoogleFonts.nunito(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 1.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Icon(
                            Icons.share,
                            color: Colors.grey,
                            size: Get.height * 0.023,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              FavoritesBottomSheet(file: file);
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: Get.height * 0.023,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static FavoritesBottomSheet({
    String? file,
  }) {
    return Get.bottomSheet(GetBuilder<PDFController>(builder: (pdf) {
      return StatefulBuilder(builder: (context, StateSetter setState) {
        return Container(
          height: Get.height * 0.35,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: Get.height * 0.08,
                    width: Get.width * 0.15,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/PDF.png'),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          file!.split('/').last.toString(),
                          style: const TextStyle(
                              fontFamily: 'fonts/Roboto-Medium.ttf',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(child: Text('4'))),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                onTap: () async {
                  setState(
                    () {},
                  );
                  if (pdf.favoriteFiles.contains(file)) {
                    pdf.favoriteFiles.remove(file);
                    
                    Get.back();
                    pdf.update();
                    showToast(
                        label: 'File removed from Favorites',
                        backgroundColor: Colors.red);
                  } else {}
                  await PreferencesServices()
                      .saveFavoritesList(PDFController.instance.favoriteFiles);

                  log(PDFController.instance.favoriteFiles.toString());
                },
                child: TextWithIcon(
                    icon: Icons.favorite,
                    text: translation(context).removeFromFavorites,
                    iconColor: Colors.red),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              GestureDetector(
                onTap: () {
                  Utils.sharePDF(fileName: file.split('/').last.toString());
                },
                child: TextWithIcon(
                  icon: Icons.share,
                  text: translation(context).share,
                ),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
            ],
          ),
        );
      });
    }));
  }
}
