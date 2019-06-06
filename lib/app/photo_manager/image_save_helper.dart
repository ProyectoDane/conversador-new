import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart';

/// Save image file as png image in the device storage. Once done, it returns
/// the path of the saved file.
Future<String> saveImageFile(File imageFile, String imageId) async {
  final Image image = decodeImage(imageFile.readAsBytesSync());
  final String path = await _localPath;

  try {
    final File savedFile = File('$path/image_$imageId.png')
      ..writeAsBytesSync(encodePng(image));
    return savedFile.path;
  } on Exception catch(e) {
    print('Image save error: $e');
    return null;
  }
}

/// Returns image saved in device storage. If the image does not exists
/// at the given path, it returns null.
Future<File> getStoredImageFile(String imageId)async {
  final String path = await _localPath;

  try {
    final File savedFile = File('$path/image_$imageId.png');

    if (savedFile.existsSync()) {
      return savedFile;
    } else {
      return null;
    }
  } on Exception catch(e) {
    print('Image save error: $e');
    return null;
  }
}

Future<String> get _localPath async {
  final Directory directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
