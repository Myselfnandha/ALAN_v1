import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // default base URL
  String baseUrl = "http://localhost:8000";

  // --------------------------------------------------------
  // Allow settings screen to change base URL
  // --------------------------------------------------------
  void setBaseUrl(String url) {
    baseUrl = url;
  }

  // --------------------------------------------------------
  // GET request (used by Memory service)
  // --------------------------------------------------------
  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("GET error: ${res.statusCode} → ${res.body}");
    }

    return jsonDecode(res.body);
  }

  // --------------------------------------------------------
  // POST request (Used by Chat + Voice)
  // --------------------------------------------------------
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode != 200) {
      throw Exception("POST error: ${res.statusCode} → ${res.body}");
    }

    return jsonDecode(res.body);
  }

  // --------------------------------------------------------
  // Chat text message
  // --------------------------------------------------------
  Future<Map<String, dynamic>> sendMessage({
    required String message,
    required String sessionId,
  }) async {
    return await post("/chat", {
      "message": message,
      "session_id": sessionId,
    });
  }

  // --------------------------------------------------------
  // Voice message (STT + TTS loop)
  // --------------------------------------------------------
  Future<Map<String, dynamic>> sendVoiceRequest({
    required String sessionId,
  }) async {
    return await post("/voice", {
      "session_id": sessionId,
    });
  }
}
