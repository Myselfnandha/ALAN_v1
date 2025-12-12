import 'package:flutter/material.dart';
import '../models/memory_item.dart';
import '../services/memory_service.dart';

class MemoryProvider extends ChangeNotifier {
  final MemoryService _service = MemoryService();

  List<MemoryItem> all = [];
  List<MemoryItem> filtered = [];

  bool isLoading = false;

  // ------------------------------------------------------------
  // Load all memory facts
  // ------------------------------------------------------------
  Future<void> loadMemory() async {
    isLoading = true;
    notifyListeners();

    final data = await _service.fetchFacts();

    all = data.map((item) {
      return MemoryItem(
        key: item["key"] ?? "",
        value: item["value"] ?? "",
        timestamp: item["updated_at"] ?? "",
      );
    }).toList();

    filtered = List.from(all);

    isLoading = false;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // Search memory
  // ------------------------------------------------------------
  void search(String query) {
    if (query.trim().isEmpty) {
      filtered = List.from(all);
    } else {
      final q = query.toLowerCase();
      filtered = all.where((m) {
        return m.key.toLowerCase().contains(q) ||
            m.value.toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  // ------------------------------------------------------------
  // Delete memory fact
  // ------------------------------------------------------------
  Future<void> deleteItem(MemoryItem item) async {
    final ok = await _service.deleteFact(item.key);

    if (ok) {
      all.removeWhere((m) => m.key == item.key);
      filtered.removeWhere((m) => m.key == item.key);
      notifyListeners();
    }
  }

  // ------------------------------------------------------------
  // Reload memory after modification
  // ------------------------------------------------------------
  Future<void> refresh() async {
    await loadMemory();
  }
}
