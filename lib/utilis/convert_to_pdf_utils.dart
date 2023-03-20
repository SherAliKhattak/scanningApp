import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
// import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart' as editor;
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scanningapp/components/flutter_toast.dart';
import 'package:scanningapp/controllers/image_controller.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';
import 'package:scanningapp/screens/main_screens/home_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../screens/main_screens/convert_to_pdf_screen/covert_to_pdf_screen.dart';

// ignore: depend_on_referenced_packages

class Utils {
  static pickImageFromGallery(
      {image_picker.ImageSource source =
          image_picker.ImageSource.gallery}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    // ignore: unnecessary_null_comparison
    if (result != null) {
      // _files!.addAll(result.files);
      ImageController.instance.list =
          result.paths.map((path) => File(path!)).toList();
      ImageController.instance.updateImagesList(ImageController.instance.list!);

      return openPage(const ConvertToPdf());
    } else {
      // Get.snackbar('alert', 'files not loaded');
    }
    ImageController.instance.update();
  }

  static openPage(Widget screen) {
    return Get.to(() => screen);
  }

  static convertImageToPDF(
      {required List<File> list, required String fileName}) async {
    final pdf = pw.Document();
    // SmartDialog.showLoading(msg: "Converting...");
    showToast(
        label: 'Converting to PDF...', backgroundColor: Colors.orangeAccent);

    //Create the PDF document

    List<pw.MemoryImage> imageList = [];

    //Add the page
    for (var file in list) {
      File compressedFile = await FlutterNativeImage.compressImage(file.path,
          quality: 60, percentage: 60);
      final image = pw.MemoryImage(
        compressedFile.readAsBytesSync(),
      );
      imageList.add(image);
    }

    for (var image in imageList) {
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              image,
              fit: pw.BoxFit.contain,
            ),
          );
        },
      ));
    }
    // Save the pdf

    final dir = await createdDirectory();
    log(dir.toString());
    var file = File("${dir.path}/$fileName");
    await file.writeAsBytes(await pdf.save());
    showToast(label: 'PDF created Successfully');
    ImageController.instance.list!.clear();
  }

  static Future<Directory> createdDirectory() async {
    const folderName = "Imagetopdfconverter";
    final path = Directory(
        "storage/emulated/0/Android/data/com.example.scanningapp/files/$folderName");
    if ((await path.exists())) {
      log("directory exists");
      return path;
    } else {
      log("directory does not exist");
      path.create();
      return path;
    }
  }

  Future<File> renameFile(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    PDFController.instance.update();
    Get.offAll(const HomeScreen());

    return file.rename(newPath);
  }

  void deleteFile(File filename, context) async {
    var pdf = PDFController.instance;
    try {
      if (await filename.exists() ||
          // ignore: iterable_contains_unrelated_type
          PDFController.instance.favoriteFiles.contains(filename)) {
        filename.delete();
        // ignore: list_remove_unrelated_type
        pdf.favoriteFiles.remove(filename);

        log('deleted');
        showToast(
            label: 'File deleted Successfully',
            backgroundColor: Theme.of(context).primaryColorDark);
        pdf.update();
        Get.to(() => const HomeScreen());
      }
    } catch (e) {
      e.toString();
      log('$e Error Deleting file');
    }
  }

  static sharePDF({required String? fileName}) async {
    try {
      final dir = await createdDirectory();
      log(dir.toString());
      await Share.shareXFiles([image_picker.XFile('${dir.path}/$fileName')]);
    } catch (e) {
      return e.toString();
    }
  }

  static viewCreatedPDF({
    required String? fileName,
  }) async {
    try {
      final dir = await createdDirectory();
      OpenFilex.open('${dir.path}/$fileName');
    } catch (e) {
      return e.toString();
    }
  }

  // static EdgeDetector() async {
  //   String? imagePath = await EdgeDetection.detectEdge;
  // }

  static pdfList() async {
    var pdfController = PDFController.instance;

    try {
      final Directory dir = Directory(
          "storage/emulated/0/Android/data/com.example.scanningapp/files/Imagetopdfconverter");

      pdfController.files.value = dir.listSync();

      return pdfController.files;

      // ignore: prefer_iterable_wheretype

      // log(pdfController.files.toString());
    } catch (e) {
      return e.toString();
    }
  }

  // static getFileSize() {
  //   File? file;
  //   int sizeInBytes = file!.lengthSync();
  //   double sizeInMb = sizeInBytes / (1024 * 1024);
  //   return sizeInMb;
  // }

  Future documentScanner(BuildContext context) async {
    try {
      File? scannedDoc = await DocumentScannerFlutter.launch(context,
          source: ScannerFileSource.CAMERA);
      ImageController.instance.list!.add(scannedDoc!);

      openPage(const ConvertToPdf());
    } catch (e) {
      return e.toString();
    }
  }

  // dynamic imageEditor(
  //   File image,
  //   int index,
  // ) async {
  //   // before using image editor

  //   try {
  //     var editedImage = await Get.to(() => EditPhotoScreen(arguments: [image]));
  //

  //     if (editedImage != null) {
  //       ImageController.instance
  //           .updateImagesList(ImageController.instance.list!);
  //       log('i am here');
  //     } else {
  //       log('no image returned');
  //     }
  //   } catch (e) {
  //     e.toString();
  //     log('${e.toString()}, exception catched here');
  //   }
  // }

  static void searchPDF(String path) {
    List<FileSystemEntity> results = [];
    if (path.isEmpty) {
      results.addAll(PDFController.instance.files);
    } else {
      results = PDFController.instance.files
          .where((value) =>
              value.path.toString().toLowerCase().contains(path.toString()))
          .toList();
    }
    PDFController.instance.searchFiles.value = results;
    PDFController.instance.update();
  }

  static void searchFavoritePDF(String path) {
    List<String> results = [];
    if (path.isEmpty) {
      results.addAll(PDFController.instance.favoriteFiles);
      log(results.toString());
    } else {
      results = PDFController.instance.favoriteFiles
          .where((value) => value.toString().toLowerCase().contains(path))
          .toList();
    }
    PDFController.instance.favoriteFiles.value = results;
    PDFController.instance.update();
  }

  dynamic imageEditor(
    File image,
    int index,
  ) async {
    Uint8List imageData = await image.readAsBytes();

    // before using image editor

    try {
      Uint8List editedImage = await Get.to(() => ImageEditor(image: imageData))!
          .then((editedImage) => editedImage);
      // ImageController.instance.list!.removeAt(index);

      if (editedImage != null) {
        return File.fromRawPath(editedImage);
      } else {
        log('no image returned');
        return null;
      }
    } catch (e) {
      e.toString();
      log('${e.toString()}, exception catched here');
    }
  }
}
