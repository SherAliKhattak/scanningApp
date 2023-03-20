// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'screens/main_screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoardingScreen.id';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            controller: _pageController,
            children: [
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      // const Image(
                      //   image: AssetImage(
                      //     'images/Documents-rafiki .png',
                      //   ),
                      // ),
                      Container(
                        height: Get.height * 0.48,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/Documents-rafiki .png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                translation(context).sCANYOURDOCUMENT,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.w200,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              //  SizedBox(
                              //   height: 33.0,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    // const Image(
                    //   image: AssetImage('images/png.png'),
                    // ),
                    Container(
                      height: Get.height * 0.48,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/png.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.068,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            translation(context).uPLOADONCLOUD,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 19.0,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          const SizedBox(
                            height: 33.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Image(
                        //   width: 230.0,
                        //   height: 270.0,
                        //   image: AssetImage('images/printer.png'),
                        // ),
                        Container(
                          height: Get.height * 0.4,
                          width: Get.width * 0.71,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/printer.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.085,
                        ),
                        Container(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            children: [
                              Text(
                                translation(context).pRINTYOURSCANNEDDOCUMENT,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.w200,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: Get.height * 0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const HomeScreen());
                                },
                                child: Container(
                                  height: Get.height * 0.055,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).indicatorColor,
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  child: Center(
                                    child: Text(
                                      translation(context).gETSTARTED,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
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
            ],
          ),
          Visibility(
            child: Positioned(
              bottom: Get.height * 0.135,
              left: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10.0,
                            dotColor: Theme.of(context).buttonColor,
                            activeDotColor: Theme.of(context).indicatorColor),
                        onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceOut,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: pageIndex == 2 ? false : true,
            child: Positioned(
              bottom: Get.height * 0.07,
              left: 160,
              child: TextButton(
                onPressed: () {
                  // setState(() {
                  //   _pageController.nextPage(
                  //       duration: const Duration(milliseconds: 500),
                  //       curve: Curves.bounceOut);
                  // });
                  Get.to(() => const HomeScreen(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 2000));
                },
                child: Text(
                  translation(context).sKIP,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Theme.of(context).indicatorColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
