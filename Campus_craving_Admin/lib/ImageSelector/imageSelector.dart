import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({required this.onImageUpload, required this.filePath});

  final ImagePicker imagePicker = ImagePicker();
  late final Function(bool) onImageUpload;
  late final Function(String) filePath;

  Future<void> _getImageFromGallery(BuildContext context) async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      onImageUpload(true);
      filePath(pickedImage.path);
    }

    Navigator.pop(context); // Close the bottom sheet
  }

  void showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Choose from Gallery'),
                  onTap: () {
                    print("gallery ");
                    _getImageFromGallery(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
