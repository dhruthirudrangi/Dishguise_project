import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({super.key});

  @override
  _UploadImagesScreenState createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  List<File> _selectedImages = []; // For Mobile
  final List<Uint8List> _webImages = []; // For Web
  bool _isUploading = false;
  bool _uploadSuccess = false; // Track if upload was successful

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      _uploadSuccess = false; // Reset success message when new images are selected
      if (kIsWeb) {
        Future.wait(pickedFiles.map((img) async {
          Uint8List bytes = await img.readAsBytes();
          _webImages.add(bytes);
        })).then((_) => setState(() {}));
      } else {
        _selectedImages = pickedFiles.map((img) => File(img.path)).toList();
      }
    });
    }

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty && _webImages.isEmpty) return;

    setState(() {
      _isUploading = true;
      _uploadSuccess = false; // Reset success message on new upload
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in")),
      );
      setState(() => _isUploading = false);
      return;
    }

    List<String> uploadedUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    String userEmail = user.email!.replaceAll(".", "_");
    String userPath = "users/$userEmail/images";

    try {
      // Upload for Mobile (File)
      for (var image in _selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = storage.ref().child("$userPath/$fileName.jpg");

        UploadTask uploadTask = ref.putFile(image);
        await uploadTask.whenComplete(() {}); // Wait for upload to finish
        String downloadUrl = await ref.getDownloadURL();
        uploadedUrls.add(downloadUrl);
      }

      // Upload for Web (Uint8List)
      for (var imageBytes in _webImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = storage.ref().child("$userPath/$fileName.jpg");

        UploadTask uploadTask = ref.putData(imageBytes);
        await uploadTask.whenComplete(() {}); // Wait for upload to finish
        String downloadUrl = await ref.getDownloadURL();
        uploadedUrls.add(downloadUrl);
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("uploads")
          .add({"images": uploadedUrls, "timestamp": Timestamp.now()});

      setState(() {
        _isUploading = false;
        _uploadSuccess = true; // Show success message
        _selectedImages.clear();
        _webImages.clear();
      });

    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Images")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImages,
            child: Text("Select Images"),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: kIsWeb ? _webImages.length : _selectedImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                if (kIsWeb) {
                  return Image.memory(
                    _webImages[index],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.file(
                    _selectedImages[index],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          if (_isUploading) CircularProgressIndicator(), // Show loading spinner
          
          if (_uploadSuccess) // Show success message above Submit button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  " Submit Successful!",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20, // Bigger font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ElevatedButton(
            onPressed: _uploadImages,
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
