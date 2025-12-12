import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String text) onSend;
  final bool loading;

  const ChatInput({
    super.key,
    required this.onSend,
    this.loading = false,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController controller = TextEditingController();

  void _submit() {
    final text = controller.text.trim();
    if (text.isEmpty || widget.loading) return;

    widget.onSend(text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(.12)),
        ),
      ),
      child: Row(
        children: [
          // -----------------------------
          // Text Field
          // -----------------------------
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(.5),
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),

          const SizedBox(width: 8),

          // -----------------------------
          // Send Button
          // -----------------------------
          GestureDetector(
            onTap: widget.loading ? null : _submit,
            child: widget.loading
                ? const SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
          ),
        ],
      ),
    );
  }
}
