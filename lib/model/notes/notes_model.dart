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

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        createdAt: DateTime.parse(json['createdAt']),
        reviewInterval: json['reviewCount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt?.toIso8601String(),
        'reviewInterval': reviewInterval,
      };

  Notes copyWith({
    int? id,
    String? title,
    String? content,
    Duration? reviewInterval,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      reviewInterval: reviewInterval ?? this.reviewInterval,
    );
  }
}

class NotesList {
  final List<Notes> list = [];
}
