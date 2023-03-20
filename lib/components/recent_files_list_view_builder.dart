import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class RecentFilesListviewBuilder extends StatefulWidget {
  final int? index;
  final FileSystemEntity? files;
  const RecentFilesListviewBuilder({Key? key, this.files, this.index})
      : super(key: key);

  @override
  State<RecentFilesListviewBuilder> createState() =>
      _RecentFilesListviewBuilderState();
}

// ignore: camel_case_types
class _RecentFilesListviewBuilderState
    extends State<RecentFilesListviewBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0, left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Utils.viewPDF(fileName: 'filename.pdf');
          });
        },
        child: GestureDetector(
          onTap: () {
            // Utils.viewAllPDFs(index: widget.index);
            // log(PDFController.instance.files.length.toString());
            // log(widget.files!.path);
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
                      right: 0.0, left: 5.0, top: 5.0, bottom: 5.0),
                  child: SizedBox(
                    height: Get.height * 0.081,
                    width: Get.width * 0.18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: const Image(
                        fit: BoxFit.fill,
                        image: AssetImage('images/PDF.png'),
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
                      SizedBox(
                        width: Get.width * 0.68,
                        child: Text(
                          widget.files!.path.split('/').last.toString(),
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.nunito(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
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
                                    color: Theme.of(context).primaryColorDark),
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
                              DateFormat.yMMMd().format(DateTime.now()),
                              style: GoogleFonts.nunito(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                            Text(
                              widget.files!.path.length.toString(),
                              style: GoogleFonts.nunito(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
