import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import '../../widgets/section_title.dart';
import '../../widgets/alan_avatar.dart';
import '../../widgets/status_chip.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Adaptive grid logic
              int crossAxisCount = 2; // mobile default

              if (constraints.maxWidth > 1300) {
                crossAxisCount = 5; // desktop / wide web screens
              } else if (constraints.maxWidth > 900) {
                crossAxisCount = 4; // large tablets / medium web
              } else if (constraints.maxWidth > 650) {
                crossAxisCount = 3; // small web/tablets
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------------------------------
                  // Header Section
                  // -------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AlanAvatar(size: 52),
                      const StatusChip(
                        label: "Online",
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const SectionTitle(title: "Welcome back, Boss"),

                  const SizedBox(height: 10),

                  Text(
                    "How can I assist you today?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(.75),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // -------------------------------
                  // Adaptive Feature Grid
                  // -------------------------------
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      children: [
                        _FeatureButton(
                          title: "Chat",
                          icon: Icons.chat_bubble_outline,
                          onTap: () => Navigator.pushNamed(context, Routes.chat),
                        ),
                        
                        _FeatureButton(
                          title: "Memory",
                          icon: Icons.storage_rounded,
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.memory),
                        ),
                        
                        _FeatureButton(
                          title: "Diagnostics",
                          icon: Icons.developer_board_outlined,
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.diagnostics),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// FEATURE BUTTON WIDGET
// --------------------------------------------------
class _FeatureButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withOpacity(.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
