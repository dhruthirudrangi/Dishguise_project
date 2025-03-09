 import 'package:url_launcher/url_launcher.dart';
import 'location_service.dart';
import 'user_settings.dart';

class WhatsAppService {
  static Future<void> sendLocationOnWhatsApp() async {
    String? phoneNumber = await UserSettings.getEmergencyContact();
    String location = await LocationService.getCurrentLocation();

    // Check if location is valid
    if (location.contains("Location services are disabled") ||
        location.contains("Location permissions are denied")) {
      return;
    }

    String message = Uri.encodeComponent(
      "SOS! I need help. My location: https://www.google.com/maps/search/?api=1&query=$location",
    );
    String whatsappUrl = "https://wa.me/$phoneNumber?text=$message";

    // Open WhatsApp with message
    await launchUrl(
      Uri.parse(whatsappUrl),
      mode: LaunchMode.externalApplication,
    );
  }
}
