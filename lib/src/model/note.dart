// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  final String title;
  final String desc;
  final DateTime time;
  NoteModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.time,
  });

  NoteModel copyWith({
    Id? id,
    String? title,
    String? desc,
    DateTime? time,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'] as String,
      desc: map['desc'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, desc: $desc, time: $time)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ desc.hashCode ^ time.hashCode;
  }
}
