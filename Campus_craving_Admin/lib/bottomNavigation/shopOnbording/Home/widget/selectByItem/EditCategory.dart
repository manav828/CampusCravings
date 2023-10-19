// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:io';
//
// import '../../../../../ImageSelector/imageSelector.dart';
//
// void main() => runApp(MaterialApp(
//       home: EditCategory(),
//     ));
//
// class EditCategory extends StatefulWidget {
//   @override
//   _EditCategoryState createState() => _EditCategoryState();
// }
//
// class _EditCategoryState extends State<EditCategory> {
//   List<String> selectedImages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchImagesFromFirestore();
//   }
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
//   bool img = false;
//
//   void updateImageStatus(bool uploaded) async {
//     setState(() {
//       img = uploaded;
//     });
//   }
//
//   Future<void> fetchImagesFromFirestore() async {
//     try {
//       final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('Select By Category')
//           .get();
//
//       final List<String> imageUrls = [];
//
//       querySnapshot.docs.forEach((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         final imageUrl = data['image_url'] as String;
//         imageUrls.add(imageUrl);
//       });
//
//       setState(() {
//         selectedImages = imageUrls;
//       });
//     } catch (e) {
//       print('Error fetching images: $e');
//     }
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
//       final firebase_storage.Reference ref = firebase_storage
//           .FirebaseStorage.instance
//           .ref()
//           .child('Category')
//           .child('$uniqueFileName.jpg');
//       final firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
//
//       await uploadTask.whenComplete(() => null);
//       final String imageUrl = await ref.getDownloadURL();
//       print('Image URL => $imageUrl');
//       storeImageUrlInFirestore(imageUrl);
//
//       return true;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return false;
//     }
//   }
//
//   void storeImageUrlInFirestore(String imageUrl) {
//     FirebaseFirestore.instance.collection('Select By Category').add({
//       'image_url': imageUrl,
//       // You can add more fields if needed
//     }).then((docRef) {
//       print('Image URL stored in Firestore with ID: ${docRef.id}');
//     }).catchError((error) {
//       print('Error storing image URL: $error');
//     });
//     fetchImagesFromFirestore();
//   }
//
//   void deleteImageFromFirestore(int index) async {
//     final String imageUrlToDelete = selectedImages[index];
//
//     try {
//       // Delete image from Firestore
//       final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('Select By Category')
//           .get();
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
//       final firebase_storage.Reference ref = firebase_storage
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Slider Images'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: selectedImages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Image.network(
//                     selectedImages[index],
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text('Image $index'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       deleteImageFromFirestore(
//                           index); // Call the deleteImage function
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

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import 'dart:io';

import '../../../../../ImageSelector/imageSelector.dart';

class EditCategory extends StatefulWidget {
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  List<String> selectedImages = [];
  List<String> selectedImageNames = [];
  TextEditingController imageNameController = TextEditingController();
  bool isLoading = false; // Added loading indicator state

  @override
  void initState() {
    super.initState();
    fetchImagesFromFirestore();
  }

  void handleImageSelection(String imagePath) async {
    // Show a dialog to enter the image name
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Image Name'),
          content: TextField(
            controller: imageNameController,
            decoration: InputDecoration(
              hintText: 'Image Name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Upload'),
              onPressed: () async {
                Navigator.of(context).pop();
                String imageName = imageNameController.text.trim();
                if (imageName.isNotEmpty) {
                  bool upload = await _uploadImage(imagePath, imageName);
                  if (upload) {
                    print("Image uploaded successfully");
                  } else {
                    print("Image upload failed");
                  }
                } else {
                  print("Image name cannot be empty.");
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool img = false;

  void updateImageStatus(bool uploaded) async {
    setState(() {
      img = uploaded;
    });
  }

  Future<void> fetchImagesFromFirestore() async {
    setState(() {
      isLoading = true; // Set loading to true when fetching starts
    });

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Select By Category')
          .get();

      final List<String> imageUrls = [];
      final List<String> imageNames = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        final imageName = data['image_name'] as String;
        imageUrls.add(imageUrl);
        imageNames.add(imageName);
      });

      setState(() {
        selectedImages = imageUrls;
        selectedImageNames = imageNames;
        isLoading = false; // Set loading to false when fetching is done
      });
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        isLoading = false; // Set loading to false on error
      });
    }
  }

  String imageUrl = '';

  Future<bool> _uploadImage(String imagePath, String imageName) async {
    try {
      final File imageFile = File(imagePath);

      if (!imageFile.existsSync()) {
        print('Image file does not exist at path: $imagePath');
        return false;
      }
      final String uniqueFileName = Uuid().v4();
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Category')
          .child('$imageName.jpg');
      final firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

      await uploadTask.whenComplete(() => null);
      final String imageUrl = await ref.getDownloadURL();
      print('Image URL => $imageUrl');

      storeImageInFirestore(imageUrl, imageName);

      // Reset the imageNameController
      imageNameController.clear();
      return true;
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }

  String convertToTitleCase(String input) {
    if (input.isEmpty) {
      return '';
    }

    final List<String> words = input.toLowerCase().split(' ');
    final List<String> capitalizedWords = [];

    for (final word in words) {
      final String capitalizedWord =
          '${word[0].toUpperCase()}${word.substring(1)}';
      capitalizedWords.add(capitalizedWord);
    }

    return capitalizedWords.join(' ');
  }

  void storeImageInFirestore(String imageUrl, String imageName) {
    imageName = convertToTitleCase(imageName);
    FirebaseFirestore.instance.collection('Select By Category').add({
      'image_url': imageUrl,
      'image_name': imageName,
    }).then((docRef) {
      print('Image and name stored in Firestore with ID: ${docRef.id}');
    }).catchError((error) {
      print('Error storing image and name: $error');
    });
    fetchImagesFromFirestore();
  }

  void deleteImageFromFirestore(int index) async {
    final String imageUrlToDelete = selectedImages[index];

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Select By Category')
          .get();

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        if (imageUrl == imageUrlToDelete) {
          doc.reference.delete();
        }
      });

      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .refFromURL(imageUrlToDelete);
      await ref.delete();

      setState(() {
        selectedImages.removeAt(index);
        selectedImageNames.removeAt(index);
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
        title: Text('Edit Category Images'),
      ),
      body: Column(
        children: <Widget>[
          // Show the loading indicator if isLoading is true
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
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
                  title: Text(selectedImageNames[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteImageFromFirestore(index);
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
          MyBottomSheet(
            onImageUpload: updateImageStatus,
            filePath: handleImageSelection,
          ).showMyBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
