// lib/services/contact_service.dart
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class ContactService {
  /// Simulated API call — replace with real HTTP request in production.
  static Future<bool> sendMessage({
    required String name,
    required String message,
  }) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'dev000586@gmail.com',
      query: _encodeQueryParameters({
        'subject': 'Portfolio Contact from $name',
        'body': 'Hi Rishabh,\n\n$message\n\nRegards,\n$name',
      }),
    );

    return await launchUrl(uri);
  }

  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
