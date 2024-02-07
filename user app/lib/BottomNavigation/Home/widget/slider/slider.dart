import 'package:carousel_slider/carousel_slider.dart';
import 'package:charueats_delivery/BottomNavigation/Home/widget/slider/sliderProvaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImgSlider extends StatefulWidget {
  const ImgSlider({Key? key}) : super(key: key);

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

class _ImgSliderState extends State<ImgSlider> {
  // List imageList = [
  //   {'id': 1, 'image_path': 'assets/1.png'},
  //   {'id': 2, 'image_path': 'assets/4.png'},
  //   {'id': 3, 'image_path': 'assets/3.png'},
  //   {'id': 4, 'image_path': 'assets/2.png'},
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SliderProvaider imageProvider =
          Provider.of<SliderProvaider>(context, listen: false);

      imageProvider.fetchImageFromFirestore();

      print('fatching data /////cart///// item dart');
    });
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  SliderProvaider? sliderProvaider;

  @override
  Widget build(BuildContext context) {
    sliderProvaider = Provider.of<SliderProvaider>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            onTap: () {
              print(currentIndex);
            },
            child: CarouselSlider(
              items: sliderProvaider!.getImageList
                  .map(
                    (item) => Image.network(
                      item,
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
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                sliderProvaider!.getImageList.asMap().entries.map((entry) {
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
