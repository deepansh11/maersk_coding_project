import 'dart:async';

import 'package:dummy_project/model/notes/notes.dart';
import 'package:flutter/material.dart';

class NotesListTile extends StatefulWidget {
  const NotesListTile(
      {super.key,
      required this.notes,
      required this.onDelete,
      required this.onTap,
      required this.onEdit});
  final Notes notes;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  State<NotesListTile> createState() => _NotesListTileState();
}

class _NotesListTileState extends State<NotesListTile> {
  late bool reviewRequired;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewRequired = widget.notes.isReviewed;
    _checkIfReviewIsRequired();
  }

  void _checkIfReviewIsRequired() {
    Future.microtask(() {
      final notes = widget.notes;
      if (notes.createdAt != null && notes.reviewInterval != null) {
        reviewRequired = !notes.isReviewed &&
            notes.createdAt!
                    .subtract(notes.reviewInterval ?? Duration.zero)
                    .minute >=
                0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.notes.title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: reviewRequired
          ? const Text(
              "Review Required",
            )
          : const SizedBox(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: widget.onEdit,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}
