class Note {
  final String note;
  final DateTime date;

  Note({
    required this.note,
    required this.date,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      note: map['note'],
      date: DateTime.parse(map['date']),
    );
  }
}
