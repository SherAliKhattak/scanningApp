import 'package:flutter/material.dart';

class UploadOnCloudScreen extends StatefulWidget {
  static const String id = 'UploadOnCloudScreen.id';
  const UploadOnCloudScreen({Key? key}) : super(key: key);

  @override
  State<UploadOnCloudScreen> createState() => _UploadOnCloudScreenState();
}

class _UploadOnCloudScreenState extends State<UploadOnCloudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          color: const Color(0xff101721),
          child: Column(
            children: [
              const Image(
                image: AssetImage('images/png.png'),
              ),
              const SizedBox(
                height: 72.0,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: const [
                    Text(
                      'UPLOAD ON CLOUD',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 33.0,
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
