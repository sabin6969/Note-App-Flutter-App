class Note {
  Note({
    required this.id,
    required this.noteTitle,
    required this.noteDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? noteTitle;
  final String? noteDescription;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["_id"],
      noteTitle: json["noteTitle"],
      noteDescription: json["noteDescription"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "noteTitle": noteTitle,
        "noteDescription": noteDescription,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
