import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ChatbotService {
  final String apiKey =
      "AIzaSyAqeptPMdi-UjbaLi13QQCoi7gx5RKpa6w"; // Replace with your actual API key
  final String model = "gemini-pro";
  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  // Function to get chatbot response
  Future<String> getResponse(String userMessage) async {
    try {
      final Map<String, dynamic> requestBody = {
        "prompt": {
          "text":
              "As a supportive counselor for domestic violence victims, provide a compassionate, detailed, and encouraging response to this message. Focus on empowerment, safety, and practical next steps. Message: $userMessage",
        },
      };

      final response = await http.post(
        Uri.parse("$apiUrl?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content'] ??
            "I'm here to help. You are not alone.";
      } else {
        return _getFallbackResponse();
      }
    } catch (e) {
      return _getFallbackResponse();
    }
  }

  // Fallback responses for error handling
  String _getFallbackResponse() {
    List<String> supportiveResponses = [
      "You are incredibly brave for seeking help. Remember, abuse is never your fault, and you deserve to live free from fear. Consider reaching out to a domestic violence hotline for confidential support.",
      "Your safety and well-being are the most important. If you're in immediate danger, please call emergency services. You are not alone, and help is available for you.",
      "You have shown great strength by speaking about this. There are support groups and professionals who understand your situation and can help you heal. Would you like resources for local support?",
      "You are not alone. Many survivors have walked this path and found their way to safety and healing. Would you like information about support services or shelters that can help?",
    ];
    return supportiveResponses[Random().nextInt(supportiveResponses.length)];
  }
}
