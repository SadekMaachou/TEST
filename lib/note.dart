class Note {
  final String note;
  final DateTime date;

  Note({
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'date': date.toIso8601String(),
      'id': int,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      note: map['note'],
      date: DateTime.parse(map['date']),
    );
  }
}
