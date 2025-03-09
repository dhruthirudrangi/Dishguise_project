import 'package:flutter/material.dart';
import 'whatsapp_service.dart';

class SOSScreen extends StatelessWidget {
  const SOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency SOS")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            WhatsAppService.sendLocationOnWhatsApp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text("Send SOS"),
        ),
      ),
    );
  }
}
