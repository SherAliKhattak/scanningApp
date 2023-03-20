import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:scanningapp/components/drag_and_drop_gridview_container.dart';
import 'package:scanningapp/components/flutter_toast.dart';
import 'package:scanningapp/controllers/image_controller.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/gridview/gridview.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';
import 'package:scanningapp/widgets/custom_textfield.dart';

import '../../../widgets/custom_button.dart';
import '../share_pdf_screen/share_pdf.dart';

class ConvertToPdf extends StatefulWidget {
  static const String id = 'ConvertToPdf.id';

  const ConvertToPdf({
    Key? key,
  }) : super(key: key);

  @override
  State<ConvertToPdf> createState() => _ConvertToPdfState();
}

class _ConvertToPdfState extends State<ConvertToPdf> {
//   @override
  // var controller = Get.put(ConvertToPDFscreenController());

  @override
  void initState() {
    super.initState();
  }

  Uint8List? editedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: const BottomNavigationBar(),
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: GetBuilder<ImageController>(builder: (controller) {
          return Column(
            children: [
              Flexible(
                child: ImageController.instance.list!.isEmpty
                    ? Container()
                    : DragAndDropGridView(
                        dragStartBehavior: DragStartBehavior.down,
                        padding: const EdgeInsets.all(10),
                        childWhenDragging: () {},
                        itemCount: controller.list!.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.70),
                        itemBuilder: (context, index) {
                          if (index == controller.list!.length) {
                            return GestureDetector(
                              onTap: () {
                                // Utils().documentScanner(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 174, 173, 173)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      translation(context).tapToScanImages,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            final file = ImageController.instance.list![index];
                            return GridviewContainer.buildFile(
                              file,
                              index,
                            );
                          }
                        },
                        onReorder: (oldIndex, newIndex) {
                          final temp = controller.list![newIndex];
                          controller.list![newIndex] =
                              controller.list![oldIndex];
                          controller.list![oldIndex] = temp;
                          setState(() {});
                        },
                        onWillAccept: (oldIndex, newIndex) {
                          if (newIndex == controller.list!.length) {
                            return false;
                          } else if (oldIndex == controller.list!.length) {
                            return false;
                          }
                          return true;
                        },
                      ),
              ),
            ],
          );
        }));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize {
    return const Size.fromHeight(40.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 15,
            color: Theme.of(context).primaryColorDark,
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        'Filename.pdf',
        style:
            TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0))),
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 15, bottom: 15.0),
                        child: Row(
                          children: const [
                            Text(
                              'Image to PDF 20220923 14.25.20',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17.0),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          leading: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          title: const Text(
                            'Rename',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          leading: Icon(
                            Icons.library_add_check,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          title: const Text(
                            'Select',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          leading: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          title: const Text(
                            'Set Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          leading: Icon(
                            FontAwesomeIcons.sort,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          title: const Text(
                            'Manual Sorting',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          leading: Icon(
                            FontAwesomeIcons.arrowDownWideShort,
                            color: Theme.of(context).primaryColorDark,
                            size: 20,
                          ),
                          title: const Text(
                            'Sort By',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: 15.0,
              color: Theme.of(context).primaryColorDark,
            )),
      ],
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  static final _formKey = GlobalKey<FormState>();
  bool value = false;
  bool ishidden = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              Utils.pickImageFromGallery();
            },
            child: Container(
                width: 45.0,
                height: 45.0,
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 18,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: 15, left: 20.0, right: 30.0, top: 10.0),
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(Container(
                  height: Get.height * 0.3,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SizedBox(
                    child: GetBuilder<ImageController>(builder: (controller) {
                      return ModalProgressHUD(
                        inAsyncCall: controller.isLoading,
                        child: Form(
                          key: _formKey,
                          child: StatefulBuilder(builder: (context, setState) {
                            return ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, left: 30),
                                          child: Text(
                                            translation(context).convertToPDF,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, top: 30),
                                          child: GestureDetector(
                                            onTap: (() {
                                              Get.back();
                                            }),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 30),
                                      child: Text(
                                        translation(context).pDFfileName,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily:
                                                'fonts/Roboto-Medium.ttf',
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 20, right: 10),
                                    //   child: CustomTextField(
                                    //     controller:
                                    //         PDFController.instance.fileName,
                                    //     isObsecure: false,
                                    //     text: 'document.pdf',
                                    //     isEnabled: true,
                                    //     validator: (value) {
                                    //       if (value!.isEmpty) {
                                    //         showToast(
                                    //             label:
                                    //                 'Filename Cannot be empty',
                                    //             backgroundColor: Colors.red);
                                    //         return '';
                                    //       } else {
                                    //         return null;
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: CustomTextField(
                                        controller:
                                            PDFController.instance.fileName,
                                        isObsecure: false,
                                        text: 'document.pdf',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            showToast(
                                                label:
                                                    'Filename Cannot be empty',
                                                backgroundColor: Colors.red);
                                            return 'enter filename to convert';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          ImageController.instance
                                              .resetIsLoading(true);

                                          await Utils.convertImageToPDF(
                                              list: ImageController
                                                  .instance.list!,
                                              fileName:
                                                  '${PDFController.instance.fileName.text}.pdf');

                                          // await Utils.savePdf(
                                          //     fileName:
                                          //         '${PDFController.instance.fileName.text}.pdf');

                                          ImageController.instance
                                              .resetIsLoading(false);

                                          return Get.to(const EditImage());
                                        } else {}
                                      },
                                      child: Center(
                                        child: CustomButton(
                                            text: translation(context).convert),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      );
                    }),
                  )));
            },
            child: Container(
              height: 45.0,
              width: Get.width / 1.8,
              decoration: BoxDecoration(
                  color: const Color(0xffff5529),
                  borderRadius: BorderRadius.circular(40.0)),
              child: Center(
                child: Text(
                  translation(context).convertToPDF,
                  style: const TextStyle(
                      fontFamily: 'Roboto', color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
