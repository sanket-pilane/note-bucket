import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:note_buckets/src/model/note.dart';
import 'package:note_buckets/src/res/assets.dart';
import 'package:note_buckets/src/services/local_db.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, this.note});

  final NoteModel? note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final localDB = LocalDBService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.desc;
    }
  }

  @override
  void dispose() {
    super.dispose();

    final title = _titleController.text;
    final desc = _descController.text;

    if (widget.note != null) {
      if (title.isEmpty && desc.isEmpty) {
        localDB.deleteNote(id: widget.note!.id);
        return;
      } else if (widget.note!.title != title || widget.note!.desc != desc) {
        final newNote = widget.note!.copyWith(
          title: title,
          desc: desc,
        );
        localDB.saveNote(note: newNote);
      }
    } else {
      final note = NoteModel(
          id: Isar.autoIncrement,
          title: title,
          desc: desc,
          time: DateTime.now());

      localDB.saveNote(note: note);
    }

    if (title.isEmpty && desc.isEmpty) {
      return;
    }

    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 30,
                  ),
                  widget.note != null
                      ? IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete note?"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Lottie.asset(kLottieDelete),
                                      Text(
                                        "This note will delete permenatly..",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        localDB.deleteNote(id: widget.note!.id);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Proceed"),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                          iconSize: 30,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: "Title", enabledBorder: InputBorder.none),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                    hintText: "Description", enabledBorder: InputBorder.none),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
