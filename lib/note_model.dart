class Note {
  final int id;
  final String text;
  final DateTime createdAt = DateTime.now();

  Note(this.id, this.text);
  Note.create()
      : id = DateTime.now().millisecondsSinceEpoch,
        text = "";
}
