import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/image_controller.dart';
import '../utilis/convert_to_pdf_utils.dart';

class GridviewContainer {
  static buildFile(
    File file,
    int index,
  ) {
    int variableSet = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: Get.height / 3.3,
          width: Get.width / 2,
          child: Stack(
            children: [
              Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: GestureDetector(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (variableSet == 0) {
                        variableSet++;
                      }
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: FileImage(file),
                                            fit: BoxFit.cover),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 190, 190, 190)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      const Color(0xffff5529),
                                                  radius: 10,
                                                  child: Text('${index + 1}')),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      const Color(0xffff5529),
                                                  radius: 10,
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        File image =
                                                            await Utils()
                                                                .imageEditor(
                                                          file,
                                                          index,
                                                        );
                                                        log('${ImageController.instance.list!.length}');
                                                        setState(() {
                                                          file = image;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        size: 15,
                                                      ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // ignore: unrelated_type_equality_checks
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffff5529),
                    radius: 10,
                    child: GestureDetector(
                      onTap: (() {
                        ImageController.instance.removeImageFromList(index);
                        log('index removed');
                      }),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
