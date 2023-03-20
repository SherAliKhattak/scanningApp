import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanYourDocScreen extends StatefulWidget {
  const ScanYourDocScreen({Key? key}) : super(key: key);

  @override
  State<ScanYourDocScreen> createState() => _ScanYourDocScreenState();
}

class _ScanYourDocScreenState extends State<ScanYourDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          color: const Color(0xff101721),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const Image(
                //   image: AssetImage(
                //     'images/Documents-rafiki .png',
                //   ),
                // ),
                Container(
                  height: Get.height * 0.02,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Documents-rafiki .png'))),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'SCAN YOUR DOCUMENT',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // SizedBox(
                      //   height: 33.0,
                      // ),
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
