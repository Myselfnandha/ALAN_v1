import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/memory_provider.dart';
import '../../widgets/memory_card.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryProvider()..loadMemory(),
      child: const _MemoryView(),
    );
  }
}

class _MemoryView extends StatelessWidget {
  const _MemoryView();

  @override
  Widget build(BuildContext context) {
    final memory = context.watch<MemoryProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Memory Storage",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // -------------------------
          // Search Bar
          // -------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              onChanged: (q) => memory.search(q),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search memory...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(.4)),
                filled: true,
                fillColor: Colors.white.withOpacity(.06),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: Colors.white.withOpacity(.2)),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // -------------------------
          // Memory List
          // -------------------------
          Expanded(
            child: memory.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : memory.filtered.isEmpty
                    ? Center(
                        child: Text(
                          "No memory entries found",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: 15,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(14),
                        itemCount: memory.filtered.length,
                        itemBuilder: (_, i) {
                          final item = memory.filtered[i];
                          return MemoryCard(item: item);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
