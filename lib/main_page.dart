import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe/upload_images_screen.dart';
import '../auth_pages.dart';
import '../picture_screen.dart';
import '../sos_screen.dart'; // Import SOSScreen

class DishGuisePage extends StatelessWidget {
  const DishGuisePage({super.key});

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0B2), Color(0xFFE1BEE7)], // Light Orange & Light Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo (Navigates to PictureScreen)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PictureScreen()),
                );
              },
              child: const CircleAvatar(
                radius: 70, // Increased size
                backgroundImage: AssetImage('assets/small_logo.png'),
              ),
            ),
            const SizedBox(height: 10),

            // DishGuise Title
            const Text(
              "DishGuise",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),

            const SizedBox(height: 30),

            // Buttons Grid
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(context, Icons.phone, 'Helpline', Colors.blue, () {
                      showHelplinesPopup(context);
                    }),
                    _buildButton(context, Icons.lightbulb, 'Inspiration', Colors.green, () {}),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(context, Icons.insert_drive_file, 'Evidence', Colors.purple, () {
                      Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => UploadImagesScreen()),
                      );
              
                    }),
                    _buildButton(context, Icons.sos, 'SOS', Colors.orange, () {
                      // Navigate to the SOS Screen when clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SOSScreen()),
                      );
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Get Emotional Support Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {},
              child: const Text("Get Emotional Support", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // Clickable Circular Buttons
  Widget _buildButton(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(25),
        elevation: 5,
      ),
      onPressed: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}

// Helplines Popup Dialog
void showHelplinesPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Women Helplines - Bengaluru"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: Icon(Icons.phone), title: Text("National Helpline: 1091")),
            ListTile(leading: Icon(Icons.phone), title: Text("Karnataka Women Helpline: 181")),
            ListTile(leading: Icon(Icons.phone), title: Text("Police Emergency: 112")),
            ListTile(leading: Icon(Icons.phone), title: Text("NGO Support: 080-23412345")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
