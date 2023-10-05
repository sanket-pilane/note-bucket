import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_buckets/src/model/note.dart';
import 'package:note_buckets/src/pages/note_page.dart';
import 'package:note_buckets/src/res/string.dart';
import 'package:note_buckets/src/services/local_db.dart';
import 'package:note_buckets/src/widgets/empty_view.dart';

import 'package:note_buckets/src/widgets/note_grid.dart';
import 'package:note_buckets/src/widgets/note_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotePage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.AppName,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isListView = !isListView;
                        });
                      },
                      icon: Icon(
                        isListView ? Icons.list : Icons.grid_view,
                        size: 30,
                      ))
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<NoteModel>>(
                  stream: LocalDBService().listenAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return EmptyView();
                    }
                    final notes = snapshot.data;

                    // if (isListView) {
                    //   return NoteList(notes: notes!);
                    // } else {
                    //   return NoteGrid(notes: notes!);
                    // }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isListView
                          ? NoteList(notes: notes!)
                          : NoteGrid(notes: notes!),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
