import 'package:flutter/material.dart';
import '../models/memory_item.dart';

class MemoryCard extends StatelessWidget {
  final MemoryItem item;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const MemoryCard({
    super.key,
    required this.item,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ------------------------------------------------
          // KEY
          // ------------------------------------------------
          Text(
            item.key,
            style: TextStyle(
              color: Colors.blueAccent.withOpacity(.9),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // ------------------------------------------------
          // VALUE
          // ------------------------------------------------
          Text(
            item.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 12),

          // ------------------------------------------------
          // FOOTER (Timestamp + optional actions)
          // ------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.timestamp,
                style: TextStyle(
                  color: Colors.white.withOpacity(.45),
                  fontSize: 12,
                ),
              ),

              Row(
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                      onPressed: onEdit,
                    ),

                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent, size: 18),
                      onPressed: onDelete,
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
