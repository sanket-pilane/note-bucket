import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_buckets/src/model/note.dart';
import 'package:note_buckets/src/pages/note_page.dart';

class NoteGridItem extends StatelessWidget {
  const NoteGridItem({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotePage(
                  note: note,
                )));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.zero,
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade500,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: GoogleFonts.poppins(fontSize: 18),
                    maxLines: 1,
                  ),
                  Flexible(
                    child: Text(
                      note.desc,
                      style: GoogleFonts.poppins(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
