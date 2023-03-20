import 'dart:developer';

import 'package:flutter/material.dart';

class TEST extends StatefulWidget {
  const TEST({Key? key}) : super(key: key);

  @override
  State<TEST> createState() => _TESTState();
}

class _TESTState extends State<TEST> {
  String? selectedLanguage;

  List<String> languages = [
    'English',
    'French',
    'German',
    'Arabic',
    'Italian',
    'Hindi',
    'Czech',
    'Bulgarian',
    'Danish',
    'Finnish',
    'Dutch',
    'Russian',
    'Korean',
    'Hungarian',
    'Polish',
    'Spanish',
    'Turkish',
    'Catalan',
    'Bengali',
    'Swedish',
    'Persian',
    'Hebrew',
    'Portuguese',
    'Norwegian',
    'Vietnamese',
    'Thai',
    'Armenian',
    'Japanese',
    'Afrikaans',
    'Greek',
    'Albanian',
    'Basque',
    'Croatian',
    'Cantonese',
    'Swahili',
    'Amharic',
    'Azerbaijani',
    'Belarusian',
    'Icelandic',
    'Gujarati',
    'Estonian',
    'Romanian',
    'Assamese',
    'Bosnian',
    'Georgian',
    'Tamil',
    'Kannada',
    'Irish',
    'Chinese',
    'Filipino',
    'Malayalam',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter SimpleDialog Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: 50,
              width: 150,
              child: InkWell(
                  onTap: () async {
                    showMyAlertDialog(context);
                  },
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${selectedLanguage ?? 'Select'}   "),
                        const Icon(
                          Icons.arrow_drop_down,
                        ),
                      ],
                    ),
                  )
                  //  DropdownButtonFormField(
                  //   items: [],
                  //   hint: Text("Select"),
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  showMyAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          actions: [
            SizedBox(
              height: 40, //height of button
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xffff5529)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
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
              width: 90.0,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          scrollable: true,
          content: StatefulBuilder(
            //* dialog is on different widget Tree. check dev-tools
            builder: (context, setStateD) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    languages.length,
                    (index) => item(
                      text: languages[index], //sent String
                      isSelected: languages[index] ==
                          selectedLanguage, //check it is selected or not
                      ontap: () {
                        /// for inner dialog changes
                        setStateD(() {
                          selectedLanguage = languages[index];
                        });
                        Navigator.of(context)
                            .pop(); // if you wish to close the dilog on Select

                        setState(() {
                          //* for class state changes
                          selectedLanguage = languages[index];
                        });
                        log(selectedLanguage!);
                      },
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget item(
      {required String text,
      required bool isSelected,
      required Function ontap}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: InkWell(
        onTap: () => ontap(),
        child: Row(
          children: [
            Text(text),
            const SizedBox(
              width: 10,
            ),
            if (isSelected)
              const Icon(Icons
                  .check), // show only check while it is selected, or you can use the same logic on Main row item
          ],
        ),
      ),
    );
  }
}
