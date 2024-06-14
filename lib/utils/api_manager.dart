import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiManager {
  static Future<Response> getAPI(
    String apiUrl,
    Map<String, String> headers,
  ) async {
    try {
      final response = await get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      return response;
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      throw Exception('Failed to get data from API');
    }
  }
}
