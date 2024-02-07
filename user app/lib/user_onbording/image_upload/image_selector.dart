// import 'package:charueats_shop/shop_onbording/phone.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MyBottomSheet extends StatelessWidget {
//   final ImagePicker imagePicker = ImagePicker();
//
//   Future<void> _getImageFromGallery(BuildContext context) async {
//     final pickedImage =
//         await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       // myPhone.isImageUploaded(true);
//       print("uploded=======");
//       // Process the picked image here
//       // You can display it in an Image widget or perform any other desired operations
//     }
//
//     Navigator.pop(context); // Close the bottom sheet
//   }
//
//   Future<void> _getImageFromCamera(BuildContext context) async {
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
//
//     if (pickedImage != null) {
//       // Process the captured image here
//       // You can display it in an Image widget or perform any other desired operations
//     }
//
//     Navigator.pop(context); // Close the bottom sheet
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('Choose from Gallery'),
//               onTap: () {
//                 _getImageFromGallery(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text('Take a Photo'),
//               onTap: () {
//                 _getImageFromCamera(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({required this.onImageUpload, required this.filePath});

  final ImagePicker imagePicker = ImagePicker();
  bool img = false;
  late final Function(bool) onImageUpload;
  late final Function(String) filePath;
  // late final String? filePath;

  Future<void> _getImageFromGallery(BuildContext context) async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // myPhone.isImageUploaded(true);
      print("uploaded");
      onImageUpload(true);
      filePath(pickedImage.path);

      // Process the picked image here
      // You can display it in an Image widget or perform any other desired operations
    }

    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Process the captured image here
      // You can display it in an Image widget or perform any other desired operations
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
                    _getImageFromGallery(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a Photo'),
                  onTap: () {
                    _getImageFromCamera(context);
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
