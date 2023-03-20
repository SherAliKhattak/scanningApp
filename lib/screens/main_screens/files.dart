import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scanningapp/components/document_listview_item.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/screens/main_screens/favourites.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Utils.pdfList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translation(context).files,
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, FavouritesScreen.id);
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.heart,
                    size: 20.0,
                    color: Theme.of(context).iconTheme.color,
                  )),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: GetBuilder<PDFController>(builder: (pdf) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                        onChanged: (value) {
                          Utils.searchPDF(value);
                        },
                        controller: PDFController.instance.searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
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
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            PDFController.instance.files.isNotEmpty
                ? Flexible(child: GetBuilder<PDFController>(builder: (pdf) {
                    return ListView.builder(
                      itemCount: pdf.searchFiles.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        var file = pdf.searchFiles.elementAt(index);

                        return Documents_Listview_Items(
                          files: file.path,
                        );
                      },
                    );
                  }))
                : SizedBox(
                    height: Get.height / 1.5,
                    child: const Center(child: Text('No Files to Show')),
                  ),
          ],
        ));
  }
}
