import 'package:get/get.dart';
import 'package:scanningapp/controllers/image_controller.dart';
import 'package:scanningapp/controllers/pdf_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ImageController>(ImageController());
    Get.put<PDFController>(PDFController());
  }
}
