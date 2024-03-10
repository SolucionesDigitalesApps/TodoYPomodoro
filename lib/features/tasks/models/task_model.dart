
class TaskModel {
  final String id;
  final String title;
  final String description;
  final int pomodoro;
  final String state;
  final String groupId;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pomodoro,
    required this.state,
    required this.groupId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    pomodoro: json["pomodoro"] ?? 0,
    state: json["state"] ?? "",
    groupId: json["group_id"] ?? "",
    userId: json["user_id"]?? "",
    createdAt: json["created_at"].toDate(),
    updatedAt: json["updated_at"]?.toDate(),
    deletedAt: json["deleted_at"]?.toDate()
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title" : title,
    "description" : description,
    "pomodoro" : pomodoro,
    "state" : state,
    "group_id" : groupId,
    "user_id" : userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt
  };

  static TaskModel get empty => TaskModel(
    id: "",
    userId: "",
    title: "",
    description: "",
    pomodoro: 0,
    state: "",
    groupId: "",
    createdAt: DateTime.now(),
    updatedAt: null,
    deletedAt: null,
  );

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    int? pomodoro,
    String? state,
    String? groupId,
    String? userId,
    DateTime? createdAt,
    required DateTime? updatedAt,
    required DateTime? deletedAt,
  }) => TaskModel(
    id: id?? this.id,
    title: title?? this.title,
    description: description?? this.description,
    pomodoro: pomodoro?? this.pomodoro,
    state: state?? this.state,
    groupId: groupId?? this.groupId,
    userId: userId?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  bool get hasPomodoro => pomodoro > 0;
  bool get hasDescription => description.isNotEmpty;
}
