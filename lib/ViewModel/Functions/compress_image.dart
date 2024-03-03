import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  static Future<XFile?> compressImage(File? sourceImage) async {
    try {
      if (sourceImage == null) {
        return null; // or handle the null case as needed
      }

      final bytes = await sourceImage.readAsBytes();
      final kb = bytes.length / 1024;
      final mb = kb / 1024;
      debugPrint("Original Image Size is $mb MB");

      final dir = await path.getTemporaryDirectory();
      String uniqueNumber = DateTime.now().millisecondsSinceEpoch.toString();
      final targetPath = '${dir.absolute.path}-$uniqueNumber.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        sourceImage.path,
        targetPath,
        minWidth: 700,
        minHeight: 700,
        quality: 30,
      );

      if (result != null) {
        final byte = await result.readAsBytes();
        final kb = byte.length / 1024;
        final mb = kb / 1024;
        debugPrint("Compressed Image Size is $mb MB");
        return  result;
      }
    } catch (e) {
      print("Error during image compression: $e");
    }

    return null;
  }
}
