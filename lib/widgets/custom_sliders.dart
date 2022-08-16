import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app_multi/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomeCarouselHomePage extends StatefulWidget {
  //final List<Map<String, dynamic>>? items;
  final List<String>? items;

  const CustomeCarouselHomePage({Key? key, this.items}) : super(key: key);

  @override
  _CustomeCarouselHomePageState createState() =>
      _CustomeCarouselHomePageState();
}

class _CustomeCarouselHomePageState extends State<CustomeCarouselHomePage> {
  int activeIndex = 0;
  void setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, Null) {
                setActiveDot(index);
              },
              autoPlay: true,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: const Duration(seconds: 7),
              viewportFraction: 1.0,
            ),
            items: widget.items!.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: item,
                            fit: BoxFit.fill,
                          )

                          /*Image(
                          image: item.image,
                          fit: BoxFit.contain,
                        ),*/
                          ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          left: 10,
          //right: 0,
          bottom: 10,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(widget.items!.length, (idx) {
                return activeIndex == idx
                    ? ActiveDot(index: idx)
                    : const InactiveDot();
              })),
        )
      ],
    );
  }
}

class ActiveDot extends StatelessWidget {
  ActiveDot({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sliderDescription[index]['title'],
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(
              sliderDescription[index]['description'],
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              softWrap: true,
            )
          ],
        ),
        /*width: 25,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),*/
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  const InactiveDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
