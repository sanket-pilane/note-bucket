import 'package:auto_animated_list/auto_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:note_buckets/src/model/note.dart';
import 'package:note_buckets/src/widgets/note_list_tile.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key, required this.notes});

  final List<NoteModel> notes;
  @override
  Widget build(BuildContext context) {
    return AutoAnimatedList<NoteModel>(
      padding: const EdgeInsets.all(20),
      items: notes,
      itemBuilder: (
        context,
        NoteModel,
        index,
        animation,
      ) {
        return SizeFadeTransition(
          animation: animation,
          child: NoteListItem(
            note: notes[index],
          ),
        );
      },
    );
  }
}
