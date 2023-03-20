import 'package:flutter/material.dart';
import 'package:scanningapp/screens/main_screens/home_screen.dart';

class PrintYourDocScreen extends StatefulWidget {
  static const String id = 'PrintYourDocScreen.id';
  const PrintYourDocScreen({Key? key}) : super(key: key);

  @override
  State<PrintYourDocScreen> createState() => _PrintYourDocScreenState();
}

class _PrintYourDocScreenState extends State<PrintYourDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          color: const Color(0xff101721),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                width: 200.0,
                height: 250.0,
                image: AssetImage('images/printer.png'),
              ),
              const SizedBox(
                height: 78.0,
              ),
              Container(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    const Text(
                      'PRINT YOUR SCANNED DOCUMENT',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
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
                    const SizedBox(
                      height: 100.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, HomeScreen.id);
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: const Color(0xffff5529),
                            borderRadius: BorderRadius.circular(40.0)),
                        child: const Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.white),
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
    );
  }
}
