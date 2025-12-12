import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/diagnostics_provider.dart';
import '../../widgets/section_title.dart';
import '../../widgets/status_chip.dart';

class DiagnosticsScreen extends StatelessWidget {
  const DiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiagnosticsProvider()..loadDiagnostics(),
      child: const _DiagnosticsView(),
    );
  }
}

class _DiagnosticsView extends StatelessWidget {
  const _DiagnosticsView();

  @override
  Widget build(BuildContext context) {
    final diag = context.watch<DiagnosticsProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Diagnostics",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: diag.isLoading ? null : () => diag.loadDiagnostics(),
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),

      body: diag.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [

                // ---------------------------------------------
                // SYSTEM STATUS
                // ---------------------------------------------
                const SectionTitle(title: "System Status"),
                const SizedBox(height: 10),

                Row(
                  children: [
                    StatusChip(
                      label: diag.livekitConnected ? "LiveKit Connected" : "LiveKit Offline",
                      color: diag.livekitConnected
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                    const SizedBox(width: 10),
                    StatusChip(
                      label: "Provider: ${diag.providerName}",
                      color: Colors.blueAccent,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ---------------------------------------------
                // MEMORY STATS
                // ---------------------------------------------
                const SectionTitle(title: "Memory Usage"),
                const SizedBox(height: 10),

                _infoTile("Facts Stored", diag.factCount.toString()),
                _infoTile("Conversations Logged", diag.conversationCount.toString()),

                const SizedBox(height: 25),

                // ---------------------------------------------
                // LIVEKIT INFO
                // ---------------------------------------------
                const SectionTitle(title: "LiveKit Info"),
                const SizedBox(height: 10),

                _infoTile("URL", diag.livekitUrl),
                _infoTile("API Key", diag.livekitKeyMasked),

                const SizedBox(height: 25),

                // ---------------------------------------------
                // RECENT LOG OUTPUT
                // ---------------------------------------------
                const SectionTitle(title: "Recent Logs"),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(.1)),
                  ),
                  child: diag.logs.isEmpty
                      ? Text(
                          "No logs available",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: 14,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: diag.logs
                              .map(
                                (l) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "• $l",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),

                const SizedBox(height: 35),
              ],
            ),
    );
  }

  Widget _infoTile(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
