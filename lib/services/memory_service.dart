import 'package:dio/dio.dart';
import 'api_service.dart';

class MemoryService {
  static final MemoryService _instance = MemoryService._internal();
  factory MemoryService() => _instance;
  MemoryService._internal();

  final ApiService _api = ApiService();

  // -------------------------------------------------------------
  // Fetch all memory facts
  // GET /memory/facts
  // -------------------------------------------------------------
  Future<List<dynamic>> fetchFacts() async {
    try {
      final data = await _api.getRequest("/memory/facts");

      if (data is Map && data.containsKey("facts")) {
        return data["facts"];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // -------------------------------------------------------------
  // Fetch conversation logs
  // GET /memory/conversations/:session_id
  // -------------------------------------------------------------
  Future<List<dynamic>> fetchConversation(String sessionId) async {
    try {
      final data = await _api.getRequest("/memory/conversations/$sessionId");

      if (data is Map && data.containsKey("logs")) {
        return data["logs"];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // -------------------------------------------------------------
  // Search memory (optional if backend supports it)
  // GET /memory/search?q=...
  // -------------------------------------------------------------
  Future<List<dynamic>> search(String query) async {
    try {
      final data = await _api.getRequest("/memory/search?q=$query");

      if (data is Map && data.containsKey("results")) {
        return data["results"];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // -------------------------------------------------------------
  // Delete a memory fact
  // DELETE /memory/facts/:key
  // -------------------------------------------------------------
  Future<bool> deleteFact(String key) async {
    try {
      final res = await Dio().delete(
        "${_api.baseUrl}/memory/facts/$key",
      );

      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
