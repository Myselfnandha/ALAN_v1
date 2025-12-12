import 'package:flutter/material.dart';

class ApiKeyEditor extends StatefulWidget {
  final String label;                  // Title: "LiveKit API Key"
  final TextEditingController controller;
  final bool obscure;                  // true for secrets, false for URLs
  final VoidCallback? onSave;
  final VoidCallback? onCopy;

  const ApiKeyEditor({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = true,
    this.onSave,
    this.onCopy,
  });

  @override
  State<ApiKeyEditor> createState() => _ApiKeyEditorState();
}

class _ApiKeyEditorState extends State<ApiKeyEditor> {
  bool _obscured = true;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------------------------
        // Label
        // ---------------------------------------
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.white.withOpacity(.8),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // ---------------------------------------
        // TextField
        // ---------------------------------------
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(.1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscured,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: InputBorder.none,
                    hintText: widget.obscure
                        ? "••••••••••••"
                        : "Enter value...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.3),
                    ),
                  ),
                ),
              ),

              // ---------------------------------------
              // Toggle Visibility
              // ---------------------------------------
              if (widget.obscure)
                IconButton(
                  icon: Icon(
                    _obscured ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.white.withOpacity(.5),
                  ),
                  onPressed: () {
                    setState(() => _obscured = !_obscured);
                  },
                ),

              // ---------------------------------------
              // Copy Button
              // ---------------------------------------
              if (widget.onCopy != null)
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    size: 19,
                    color: Colors.white.withOpacity(.45),
                  ),
                  onPressed: widget.onCopy,
                ),

              const SizedBox(width: 6),
            ],
          ),
        ),

        // ---------------------------------------
        // Save Button (Optional)
        // ---------------------------------------
        if (widget.onSave != null) ...[
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: widget.onSave,
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 16),
      ],
    );
  }
}
