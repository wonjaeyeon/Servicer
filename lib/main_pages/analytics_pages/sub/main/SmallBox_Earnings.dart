import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SmallBoxEarnings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCarousel(context, 0);
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
          stops: [0.0, 0.2, 0.8, 1.0], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(0),
        // you may want to use an aspect ratio here for tablet support

        child: CarouselSlider(
          items: [
            // Container(color: Colors.red, height: 30),
            // Container(color: Colors.green, height: 30),
            // Container(color: Colors.blue, height: 30),
            // Container(color: Colors.yellow, height: 30),
            // Container(color: Colors.orange, height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('월간  ', style: TextStyle(fontSize: 16)),
                Text('1,319,000', style: TextStyle(fontSize: 20)),
                Text('원 ', style: TextStyle(fontSize: 20)),
                Text('▲', style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('주간  ', style: TextStyle(fontSize: 16)),
                Text('400,510', style: TextStyle(fontSize: 20)),
                Text('원 ', style: TextStyle(fontSize: 20)),
                Text('▼', style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('오늘  ', style: TextStyle(fontSize: 16)),
                Text('90,100', style: TextStyle(fontSize: 20)),
                Text('원 ', style: TextStyle(fontSize: 20)),
                Text('▲', style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
          carouselController: CarouselController(),
          options: CarouselOptions(
            scrollDirection: Axis.vertical,
            viewportFraction: 0.4,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
        ),
      ),
    );
  }
}
