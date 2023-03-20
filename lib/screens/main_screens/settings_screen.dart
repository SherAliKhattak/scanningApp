import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/main.dart';
import 'package:scanningapp/screens/main_screens/convert_to_pdf_screen/covert_to_pdf_screen.dart';
import '../../providers/theme_provider.dart';
import '../../models/language_model.dart';

const List<String> list = <String>['Default', 'Two', 'Three', 'Four'];

class SettingsScreen extends StatefulWidget {
  static const String id = 'SettingsScreen.id';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Language selected = Language(1, translation(context).english, 'en');
    List<Language> languagesList = <Language>[
      Language(1, 'English', 'en'),
      Language(2, "French", 'fr'),
      Language(3, 'Urdu', 'ur'),
      Language(4, 'Chinese', 'zh'),
    ];

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          translation(context).settings,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(right: 25.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const ConvertToPdf());
              },
              child: Icon(
                FontAwesomeIcons.thumbsUp,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(top: 4.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.share_sharp,
                        color: Colors.grey,
                        size: 20,
                      ),
                      title: Text(
                        translation(context).shareApp,
                        style: GoogleFonts.nunito(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(top: 4.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Theme.of(context).cardColor),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.document_scanner,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).scanSettings,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.language,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).languageOptions,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                        builder: (context, newState) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    title: Text(
                                      'Select Language',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          for (int i = 0;
                                              i < languagesList.length;
                                              i++)
                                            ListTile(
                                                onTap: () {
                                                  newState(() {
                                                    setState(() {
                                                      selected =
                                                          languagesList[i];
                                                    });
                                                  });
                                                },
                                                title: Text(
                                                  languagesList[i].name!,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark),
                                                ),
                                                trailing: Radio<Language>(
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Theme.of(context)
                                                                .primaryColorDark),
                                                    activeColor: Colors.blue,
                                                    value: languagesList[i],
                                                    groupValue: selected,
                                                    onChanged: (Language?
                                                        value) async {
                                                      if (value != null) {
                                                        Locale locale =
                                                            await setLocale(value
                                                                .languageCode!);
                                                        // ignore: use_build_context_synchronously
                                                        MyApp.setLocale(
                                                            context, locale);
                                                      }
                                                      newState(() {
                                                        setState(() {
                                                          selected = value!;
                                                        });
                                                      });
                                                    })),
                                        ],
                                      ),
                                    ),
                                    buttonPadding: const EdgeInsets.only(
                                        right: 50.0, bottom: 100.0),
                                    actions: <Widget>[
                                      SizedBox(
                                        height: 40, //height of button
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Color(0xffff5529)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Color(0xffff5529),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100.0,
                                        height: 40.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xffff5529)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selected.name!,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.dark_mode,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).darkMode,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            trailing: Container(
                              margin: const EdgeInsets.all(0.1),
                              height: 35.0,
                              width: 50,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: CupertinoSwitch(
                                  // This bool value toggles the switch.
                                  value: themeProvider.isDarkMode,
                                  thumbColor: Colors.deepOrange,
                                  trackColor: Colors.blueGrey,

                                  onChanged: (bool value) {
                                    final provider = Provider.of<ThemeProvider>(
                                        context,
                                        listen: false);
                                    provider.toggleTheme(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(top: 4.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.textsms,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).feedBack,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.gpp_maybe,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).privacyPolicy,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.all(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.error,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Text(
                              translation(context).version,
                              style: GoogleFonts.nunito(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            trailing: const Text('1.3.2B'),
                          ),
                        ),
                      ],
                    ),
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
//fillColor: MaterialStateColor.resolveWith((states) => Colors.white),