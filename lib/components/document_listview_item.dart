import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:scanningapp/components/flutter_toast.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/screens/main_screens/home_screen.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';

import '../services/local_db.dart';
import 'alert_dialog.dart';

// ignore: camel_case_types, must_be_immutable
class Documents_Listview_Items extends StatefulWidget {
  String? files;

  Documents_Listview_Items({
    Key? key,
    this.files,
  }) : super(key: key);

  @override
  State<Documents_Listview_Items> createState() =>
      _Documents_Listview_ItemsState();
}

// ignore: camel_case_types
class _Documents_Listview_ItemsState extends State<Documents_Listview_Items> {
  @override
  void initState() {
    super.initState();
    Utils.pdfList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0, left: 5, right: 5),
      child: InkWell(
        onTap: () {
          log('message');
          OpenFilex.open(widget.files);
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
                      widget.files!.split('/').last.toString(),
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
                                  color: Colors.black),
                              child: Center(
                                  child: Text(
                                '1',
                                style: GoogleFonts.nunito(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 14),
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
                      width: Get.width / 1.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Utils.sharePDF(
                                  fileName:
                                      widget.files!.split('/').last.toString());
                              log(' Share pressed');
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.grey,
                              size: Get.height * 0.023,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              log('button is pressed');
                              filesBottomSheet(
                                file: widget.files,
                              );
                              // ignore: avoid_unnecessary_containers
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: Get.height * 0.023,
                            ),
                          )
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

  static filesBottomSheet({String? file}) {
    return Get.bottomSheet(GetBuilder<PDFController>(builder: (pdf) {
      return StatefulBuilder(builder: (context, StateSetter newState) {
        return Container(
          height: Get.height * 0.5,
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
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
                onTap: () {
                  AlertDialogue.renameDialog(context, file);
                },
                child: TextWithIcon(
                  icon: Icons.edit,
                  text: translation(context).rename,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              InkWell(
                onTap: () async {
                  pdf.update();
                  if (PDFController.instance.favoriteFiles.contains(file) ==
                      false) {
                    pdf.favoriteFiles.add(file);
                    pdf.update();
                    showToast(
                        label: 'File added to Favorites',
                        backgroundColor: Colors.green);
                  } else {
                    pdf.favoriteFiles.remove(file);
                    pdf.update();
                    showToast(
                        label: 'File removed from Favorites',
                        backgroundColor: Colors.red);
                  }
                  await PreferencesServices().saveFavoritesList(
                    PDFController.instance.favoriteFiles,
                  );
                  log(PDFController.instance.favoriteFiles.toString());
                },
                child: TextWithIcon(
                  icon: Icons.favorite,
                  text: pdf.favoriteFiles.contains(file)
                      ? 'Added to Favorites'
                      : translation(context).addToFavorites,
                  iconColor: pdf.favoriteFiles.contains(file)
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              GestureDetector(
                onTap: (() {
                  Utils.sharePDF(fileName: file.split('/').last.toString());
                }),
                child: TextWithIcon(
                  icon: Icons.share,
                  text: translation(context).share,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              InkWell(
                onTap: () {
                  newState(
                    () {
                      Utils().deleteFile(File(file), context);
                      Get.offAll(() => const HomeScreen());
                    },
                  );
                },
                child: TextWithIcon(
                  icon: Icons.delete,
                  text: translation(context).delete,
                ),
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

class TextWithIcon extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? text;
  const TextWithIcon({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: Get.width * 0.05,
          ),
          Text(
            text!,
            style:
                GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }
}
