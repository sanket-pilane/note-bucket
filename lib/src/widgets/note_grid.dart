import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:note_buckets/src/model/note.dart';
import 'package:note_buckets/src/widgets/note_grid_tile.dart';

class NoteGrid extends StatelessWidget {
  const NoteGrid({super.key, required this.notes});

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return LiveGrid.options(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index, animation) {
          return NoteGridItem(note: notes[index]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
        itemCount: notes.length,
        options: const LiveOptions());
  }
}
