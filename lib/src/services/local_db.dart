import 'package:isar/isar.dart';
import 'package:note_buckets/src/model/note.dart';

class LocalDBService {
  late Future<Isar> db;

  LocalDBService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [NoteModelSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> saveNote({required NoteModel note}) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.noteModels.putSync(note));
  }

  Stream<List<NoteModel>> listenAllNotes() async* {
    final isar = await db;
    yield* isar.noteModels.where().watch(fireImmediately: true);
  }

  void deleteNote({required int id}) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.noteModels.deleteSync(id));
  }
}
