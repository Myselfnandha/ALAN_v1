import 'package:flutter/material.dart';
import '../models/memory_item.dart';
import '../widgets/memory_card.dart';

class MemoryViewer extends StatelessWidget {
  final List<MemoryItem> items;
  final bool shrink;
  final bool showActions;
  final Function(MemoryItem item)? onDelete;
  final Function(MemoryItem item)? onEdit;

  const MemoryViewer({
    super.key,
    required this.items,
    this.shrink = false,
    this.showActions = false,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          "No memory entries available",
          style: TextStyle(
            color: Colors.white.withOpacity(.6),
            fontSize: 15,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: shrink,
      physics: shrink ? const NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return MemoryCard(
          item: item,
          onDelete: showActions && onDelete != null
              ? () => onDelete!(item)
              : null,
          onEdit: showActions && onEdit != null
              ? () => onEdit!(item)
              : null,
        );
      },
    );
  }
}
