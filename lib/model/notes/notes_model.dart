class Notes {
  final int id;
  String title;
  String content;
  bool isReviewed;
  DateTime? createdAt = DateTime.now();
  Duration? reviewInterval = const Duration(seconds: 60);

  Notes({
    required this.id,
    required this.title,
    required this.content,
    this.isReviewed = false,
    this.reviewInterval,
    this.createdAt,
  });
}

class NotesList {
  final List<Notes> list = [];
}
