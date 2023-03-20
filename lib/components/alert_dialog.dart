import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';

import '../constant.dart';

class AlertDialogue {
  static Future<dynamic> renameDialog(BuildContext context, String? path) {
    return Get.dialog(Container(
      margin: const EdgeInsets.all(1),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Theme.of(context).cardColor,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 50.0,
          ),
          child: Text(
            'Rename',
            style: settings_item_text_style.copyWith(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20.0,
          color: Theme.of(context).primaryColorDark,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: PDFController.instance.renameController,
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                isCollapsed: true,
                // Added this
                contentPadding: const EdgeInsets.all(8),
                isDense: true,
                border: const OutlineInputBorder(),
                //  <- you can it to 0.0 for no space

                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),

                suffix: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 15.0,
                  ),
                ),
                suffixIconConstraints:
                    const BoxConstraints(maxWidth: 32, maxHeight: 32),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                hintText: path!.split('/').last.toString(),
              ),
            ),
          ],
        ),
        buttonPadding: const EdgeInsets.only(right: 50.0, bottom: 100.0),
        actions: [
          SizedBox(
            height: 40, //height of button
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xffff5529)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onPressed: () {
                // setState(() {
                //   Navigator.pop(context);
                // });
                Get.back();
              },
              child: const Text(
                'CANCLE',
                style: TextStyle(
                    color: Color(0xffff5529),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
            ),
          ),
          SizedBox(
            width: 100.0,
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                Utils().renameFile(
                    File(path), PDFController.instance.renameController.text);
                Get.back();
                log(path.toString());
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffff5529)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
