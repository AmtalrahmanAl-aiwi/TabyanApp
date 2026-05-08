import 'package:flutter/material.dart';
import 'package:tabyan1/design_screen.dart';

class ImageScreen extends StatelessWidget {
  final List<String> images = [
    "assets/images/image.webp",
    "assets/images/image.1.webp",
    "assets/images/image.2.jpg",
    "assets/images/image.3.jfif",
    "assets/images/image.4.webp",
    "assets/images/image.5.webp",
    "assets/images/image.6.webp",
    "assets/images/image.7.webp",
    "assets/images/image.8.webp",
    "assets/images/image.9.webp",
  ];

  ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 2, 40),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DesignScreen(selectedImage: images[index]),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.asset(images[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
