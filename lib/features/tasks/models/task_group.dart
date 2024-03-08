class TaskGroupModel {
  final String id;
  final String label;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  TaskGroupModel({
    required this.id,
    required this.label,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TaskGroupModel.fromJson(Map<String, dynamic> json) => TaskGroupModel(
    id: json["id"] ?? "",
    label: json["label"] ?? "",
    userId: json["user_id"] ?? "",
    createdAt: json["created_at"].toDate(),
    updatedAt: json["updated_at"]?.toDate(),
    deletedAt: json["deleted_at"]?.toDate()
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt
  };

  static get empty => TaskGroupModel(
    id: "-1",
    label: "Casa",
    createdAt: DateTime.now(),
    updatedAt: null,
    deletedAt: null,
    userId: '1'
  );

  TaskGroupModel copyWith({
    String? id,
    String? label,
    String? userId,
    DateTime? createdAt,
    required DateTime? updatedAt,
    required DateTime? deletedAt,
  }) => TaskGroupModel(
    id: id ?? this.id,
    label: label ?? this.label,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}
