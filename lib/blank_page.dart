import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inspiration")),
      body: const Center(child: Text("Content will be added soon", style: TextStyle(fontSize: 20))),
    );
  }
}