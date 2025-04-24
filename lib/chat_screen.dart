import 'package:flutter/material.dart';
import 'chatbot_service.dart'; // Ensure you have this file

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatbotService chatbot = ChatbotService();
  List<Map<String, String>> messages = []; // Fix: Declare messages properly

  void sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return; // Prevent empty messages

    setState(() {
      messages.add({"sender": "You", "text": userMessage});
    });

    String botResponse = await chatbot.getResponse(userMessage);

    setState(() {
      messages.add({"sender": "Gemini", "text": botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Support Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]["text"]!),
                  subtitle: Text(messages[index]["sender"]!),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: sendMessage,
              decoration: InputDecoration(
                labelText: "Type a message...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
