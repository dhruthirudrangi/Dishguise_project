import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static Future<void> setEmergencyContact(String number) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emergency_contact', number);
  }

  static Future<String?> getEmergencyContact() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('emergency_contact') ??
        "918867050130"; // Default number
  }
}
