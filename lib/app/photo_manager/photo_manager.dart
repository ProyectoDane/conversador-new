import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_syntactic_sorter/ui/settings/lang/lang_localizations.dart';

/// This class handles capture of image from the camera or the gallery and
/// returns the image selected.
class PhotoManager {
  /// Singleton constructor
  factory PhotoManager()=> _photoManager;
  PhotoManager._internal();
  static final PhotoManager _photoManager = PhotoManager._internal();

  Function(File)_imageSelectCallback;

  /// This display dialog showing the options availabe for getting
  /// a photo
  Future<void>showPhotoMenu(BuildContext context, Function(File)callback) async{
    _imageSelectCallback = callback;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) =>
         AlertDialog(
          title: _getText(context, 'photo_source_prompt'),
          actions: <Widget>[
            FlatButton(
              child: _getText(context, 'camera_option'),
              onPressed:(){
                _getImage(true);
                Navigator.pop(context);
              }
            ),
            FlatButton(
              child: _getText(context, 'gallery_option'),
              onPressed: (){
                _getImage(false);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: _getText(context, 'cancel_option'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        )
    );
  }

  Text _getText(BuildContext context, String textKey) {
    final String string = LangLocalizations.of(context).trans(textKey);
    return Text(string);
  }

  Future<void> _getImage(bool fromCamera) async {
    final ImageSource src = fromCamera?ImageSource.camera:ImageSource.gallery;
    // This next line brings up either the native camera or the native image
    // gallery. It will not continue beyond this line until the user either
    // selects an image or dismisses the view.
    final File image = await ImagePicker.pickImage(source: src);
    _imageSelectCallback(image);
    _imageSelectCallback = null;
  }
}