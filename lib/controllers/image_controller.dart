import 'dart:io';
import 'package:get/get.dart';

class ImageController extends GetxController implements GetxService {
  List<File>? list = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? selectedFile;

  resetIsLoading(bool state) {
    _isLoading = state;
    update();
  }

  // ignore: no_leading_underscores_for_local_identifiers
  updateImagesList(List<File> _list) {
    list = _list;
    update();
  }

  removeImageFromList(int index) {
    list!.removeAt(index);
    update();
  }

  setIndex(int index) {
    selectedFile = index;
    update();
  }

  updateSelectedFile(File file, int index, var image) {
    list!.removeAt(index);
    list!.insert(index, image);
    update();
  }

  static ImageController get instance => Get.put(ImageController());
}

 


  



//   late TextEditingController renameController;

//   final pdf = pw.Document();
//   Share share = Share();
//   late RxString fileName;
//   @override
//   onInit() {}

  

//   createPDF() async {
//     for (var img in files!) {
//       final image = pw.MemoryImage(File(img.path!).readAsBytesSync());

//       log('pdf created successfully');
//       pdf.addPage(pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context context) {
//             return pw.Center(child: pw.Image(image));
//           }));
//     }
//   }

//   savePDF({filename}) async {
//     try {
     
//       final file = File('${dir!.path}/$fileName.pdf');
//       log(dir.path);
//       await file.writeAsBytes(await pdf.save());

//       showPrintedMessage('success', 'saved to documents');

    
//     } catch (e) {
//       log(e.toString());
//       showPrintedMessage('error', e.toString());
//     }
//   }

//   showPrintedMessage(String title, String msg) {
//     return Get.snackbar(title, msg);
//   }
// }
