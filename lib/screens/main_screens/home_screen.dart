import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scanningapp/screens/main_screens/files.dart';
import 'package:scanningapp/utilis/convert_to_pdf_utils.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen.id';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  PageController controller = PageController(initialPage: 0);
  final list = [
    const Home(),
    const SettingsScreen(),
  ];

  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          await Utils().documentScanner(context);
          // log('${ImageController.instance.scannedDocs}');
        },
        child: Container(
          width: 65.0,
          height: 65.0,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xff823f3c),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(0.0, 0.0),
              )
            ],
          ),
          child: const Align(
              alignment: Alignment.center,
              child: Image(
                width: 35.0,
                height: 35.0,
                color: Colors.white,
                image: AssetImage(
                  'images/scan_icon_184177 (1).png',
                ),
              )),
        ),
      ),
      // backgroundColor: const Color(0xff101721),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    itemCount: list.length,
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return list[index];
                    })),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        30.0,
                      ),
                      topRight: Radius.circular(30.0))),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.jumpToPage(0);
                    },
                    icon: Icon(
                      FontAwesomeIcons.solidFilePdf,
                      size: 17,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      controller.jumpToPage(1);
                    },
                    icon: Icon(
                      FontAwesomeIcons.gear,
                      size: 17,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
