// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../../ImageSelector/imageSelector.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
//
// class EditSlider extends StatefulWidget {
//   @override
//   _EditSliderState createState() => _EditSliderState();
// }
//
// class _EditSliderState extends State<EditSlider> {
//   List<String> selectedImages = [];
//
//   void handleImageSelection(String imagePath) async {
//     // Implement your logic to handle the selected image here
//     setState(() {
//       selectedImages.add(imagePath);
//     });
//
//     print("call");
//     if (imagePath != null) {
//       bool upload = await _uploadImage(
//           imagePath!); // Call _uploadImage and await its result
//       if (upload) {
//         print("Image uploaded successfully");
//       } else {
//         print("Image upload failed");
//       }
//     }
//   }
//
//   Future<void> fetchImagesFromFirestore() async {
//     // Fetch images from Firestore "slider" collection
//     final QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('slider').get();
//
//     final List<String> imageUrls = [];
//
//     // Extract image URLs from Firestore documents
//     querySnapshot.docs.forEach((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       final imageUrl = data['image_url'] as String;
//       imageUrls.add(imageUrl);
//       // print(imageUrl);
//     });
//
//     setState(() {
//       selectedImages = imageUrls;
//     });
//   }
//
//   void deleteImage(int index) {
//     setState(() {
//       selectedImages.removeAt(index);
//     });
//   }
//
//   bool img = false;
//   String? imgpath;
//   void updateImageStatus(bool uploaded) async {
//     setState(() {
//       img = uploaded;
//     });
//   }
//
//   String imageUrl = '';
//   Future<bool> _uploadImage(String imagePath) async {
//     try {
//       final File imageFile = File(imagePath);
//
//       if (!imageFile.existsSync()) {
//         print('Image file does not exist at path: $imagePath');
//         return false;
//       }
//       final String uniqueFileName = Uuid().v4(); // Generate a unique UUID
//       final firabase_storage.Reference ref = firabase_storage
//           .FirebaseStorage.instance
//           .ref()
//           .child('Slider')
//           .child('$uniqueFileName.jpg');
//       final firabase_storage.UploadTask uploadTask = ref.putFile(imageFile);
//
//       await uploadTask.whenComplete(() => null);
//       final String imageUrl = await ref.getDownloadURL();
//       print('Image URL => $imageUrl');
//       storeImageUrlInFirestore(imageUrl);
//       return true;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return false;
//     }
//   }
//
//   void deleteImageFromFirestore(int index) async {
//     final String imageUrlToDelete = selectedImages[index];
//
//     try {
//       // Delete image from Firestore
//       final QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('slider').get();
//
//       querySnapshot.docs.forEach((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         final imageUrl = data['image_url'] as String;
//         if (imageUrl == imageUrlToDelete) {
//           // Delete document if the image URL matches
//           doc.reference.delete();
//         }
//       });
//
//       // Delete image from Firebase Storage
//       final firabase_storage.Reference ref = firabase_storage
//           .FirebaseStorage.instance
//           .refFromURL(imageUrlToDelete);
//       await ref.delete();
//
//       // Remove the deleted image URL from the list
//       setState(() {
//         selectedImages.removeAt(index);
//       });
//
//       print('Image deleted successfully');
//     } catch (e) {
//       print('Error deleting image: $e');
//     }
//   }
//
//   void storeImageUrlInFirestore(String imageUrl) {
//     FirebaseFirestore.instance.collection('slider').add({
//       'image_url': imageUrl,
//       // You can add more fields if needed
//     }).then((docRef) {
//       print('Image URL stored in Firestore with ID: ${docRef.id}');
//     }).catchError((error) {
//       print('Error storing image URL: $error');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Images'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: selectedImages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Image.file(
//                     File(selectedImages[index]),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text('Image $index'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       deleteImageFromFirestore(index);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Show the bottom sheet to select an image
//           MyBottomSheet(
//             onImageUpload: updateImageStatus,
//             filePath: handleImageSelection, // Pass the callback function
//           ).showMyBottomSheet(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: EditSlider(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../../../../../ImageSelector/imageSelector.dart';

void main() => runApp(MaterialApp(
      home: EditSlider(),
    ));

class EditSlider extends StatefulWidget {
  @override
  _EditSliderState createState() => _EditSliderState();
}

class _EditSliderState extends State<EditSlider> {
  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    fetchImagesFromFirestore();
  }

  void handleImageSelection(String imagePath) async {
    // Implement your logic to handle the selected image here
    setState(() {
      selectedImages.add(imagePath);
    });

    print("call");
    if (imagePath != null) {
      bool upload = await _uploadImage(
          imagePath!); // Call _uploadImage and await its result
      if (upload) {
        print("Image uploaded successfully");
      } else {
        print("Image upload failed");
      }
    }
  }

  bool img = false;

  void updateImageStatus(bool uploaded) async {
    setState(() {
      img = uploaded;
    });
  }

  // Future<void> fetchImagesFromFirestore() async {
  //   try {
  //     final QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('slider').get();
  //
  //     final List<String> imageUrls = [];
  //
  //     querySnapshot.docs.forEach((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       final imageUrl = data['image_url'] as String;
  //       imageUrls.add(imageUrl);
  //     });
  //
  //     setState(() {
  //       selectedImages = imageUrls;
  //     });
  //   } catch (e) {
  //     print('Error fetching images: $e');
  //   }
  // }
  Future<void> fetchImagesFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('slider').get();

      final List<String> imageUrls = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        imageUrls.add(imageUrl);
      });

      setState(() {
        selectedImages = imageUrls;
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  String imageUrl = '';
  Future<bool> _uploadImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);

      if (!imageFile.existsSync()) {
        print('Image file does not exist at path: $imagePath');
        return false;
      }
      final String uniqueFileName = Uuid().v4(); // Generate a unique UUID
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Slider')
          .child('$uniqueFileName.jpg');
      final firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

      await uploadTask.whenComplete(() => null);
      final String imageUrl = await ref.getDownloadURL();
      print('Image URL => $imageUrl');
      storeImageUrlInFirestore(imageUrl);

      return true;
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }

  void storeImageUrlInFirestore(String imageUrl) {
    FirebaseFirestore.instance.collection('slider').add({
      'image_url': imageUrl,
      // You can add more fields if needed
    }).then((docRef) {
      print('Image URL stored in Firestore with ID: ${docRef.id}');
    }).catchError((error) {
      print('Error storing image URL: $error');
    });
    fetchImagesFromFirestore();
  }

  void deleteImageFromFirestore(int index) async {
    final String imageUrlToDelete = selectedImages[index];

    try {
      // Delete image from Firestore
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('slider').get();

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        if (imageUrl == imageUrlToDelete) {
          // Delete document if the image URL matches
          doc.reference.delete();
        }
      });

      // Delete image from Firebase Storage
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .refFromURL(imageUrlToDelete);
      await ref.delete();

      // Remove the deleted image URL from the list
      setState(() {
        selectedImages.removeAt(index);
      });

      print('Image deleted successfully');
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Slider Images'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    selectedImages[index],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Image $index'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteImageFromFirestore(
                          index); // Call the deleteImage function
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the bottom sheet to select an image
          MyBottomSheet(
            onImageUpload: updateImageStatus,
            filePath: handleImageSelection, // Pass the callback function
          ).showMyBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
