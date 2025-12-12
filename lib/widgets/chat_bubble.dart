import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isUser
        ? Colors.blueAccent.withOpacity(0.85)
        : Colors.white.withOpacity(0.08);

    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withOpacity(.05),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.white.withOpacity(.9),
              fontSize: 15,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
