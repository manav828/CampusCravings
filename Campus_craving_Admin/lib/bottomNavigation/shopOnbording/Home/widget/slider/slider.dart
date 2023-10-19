import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editSlider.dart';
import 'imageProvaider/imageProvaider.dart';

class ImgSlider extends StatefulWidget {
  const ImgSlider({Key? key}) : super(key: key);

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

ImageUrlProvider? imageUrlProvider;

class _ImgSliderState extends State<ImgSlider> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("function called");
    fetchImageFromFirestore();
  }

  List<String> selectedImages = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  Future<void> fetchImageFromFirestore() async {
    // Fetch images from Firestore "slider" collection
    _subscription = FirebaseFirestore.instance
        .collection('slider')
        .snapshots()
        .listen((querySnapshot) {
      final List<String> imageUrls = [];

      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final imageUrl = data['image_url'] as String;
        imageUrls.add(imageUrl);
      });

      setState(() {
        selectedImages = imageUrls;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the stream subscription in the dispose method
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            onTap: () {
              print(currentIndex);
              imageUrlProvider?.fetchImagesFromFirestore();
            },
            child: CarouselSlider(
              items: selectedImages
                  .map(
                    (imageUrl) => Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2.7,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        // Edit pencil icon
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditSlider(),
                ),
              );
              // Implement your edit logic here
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 17 : 7,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          currentIndex == entry.key ? Colors.red : Colors.teal),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
