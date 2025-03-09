import 'package:flutter/material.dart';
import '../main_page.dart';

class PictureScreen extends StatefulWidget {
  const PictureScreen({super.key});

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  int homeTapCount = 0;

  void _onHomePressed() {
    setState(() {
      homeTapCount++;
      if (homeTapCount == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DishGuisePage()), // ✅ Navigate to MainPage
        );
        homeTapCount = 0; // Reset count after navigation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/stealth_image.png", fit: BoxFit.contain),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.white, size: 30),
                    onPressed: _onHomePressed,
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.star, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.history, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}