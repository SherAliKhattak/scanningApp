import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanningapp/components/recent_files_list_view_builder.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/screens/main_screens/home_screen.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';
import 'package:scanningapp/widgets/custom_button.dart';
import 'package:scanningapp/widgets/separator.dart';

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  @override
  void initState() {
    Utils.pdfList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: InkWell(
            onTap: (() {
              Get.offAll(() => const HomeScreen());
            }),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorDark,
            )),
      ),
      body: SizedBox(
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ImageContainer(),
                const PdfNameWithEditIcon(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Utils.sharePDF(
                        fileName:
                            '${PDFController.instance.fileName.text}.pdf');
                  },
                  child: CustomButton(
                    text: translation(context).share,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.viewCreatedPDF(
                        fileName:
                            '${PDFController.instance.fileName.text}.pdf');
                  },
                  child: CustomButton(
                    text: translation(context).openWith,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecentFilesText(),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                    height: Get.height * 0.5,
                    width: Get.width,
                    child: GetBuilder<PDFController>(builder: (controller) {
                      return ListView.builder(
                        itemCount: controller.files.length,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          var files = controller.files[index];
                          if (index <= 4) {
                            return RecentFilesListviewBuilder(
                              index: index,
                              files: files,
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecentFilesText extends StatelessWidget {
  const RecentFilesText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            SizedBox(
              height: 1,
              width: Get.width * 0.23,
              child: MySeparator(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            SizedBox(
              width: Get.width * 0.1,
            ),
            Text(
              translation(context).recentFiles,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark, fontSize: 15),
            ),
            SizedBox(
              width: Get.width * 0.08,
            ),
            SizedBox(
              height: 1,
              width: Get.width * 0.23,
              child: MySeparator(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfNameWithEditIcon extends StatelessWidget {
  const PdfNameWithEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${PDFController.instance.fileName.text}.pdf',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(
            width: Get.width * 0.06,
          ),
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('images/PDF.png'),
                )),
            child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 61, 56, 56),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    height: 25,
                    width: 25,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
