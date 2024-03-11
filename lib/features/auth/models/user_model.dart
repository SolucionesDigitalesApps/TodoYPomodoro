
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.enabled,
    required this.lastGroupId,
    required this.lastTaskOrder,
  });

  final String id;
  final String email;
  final bool enabled;
  final String lastGroupId;
  final int lastTaskOrder;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    enabled: json["enabled"]?? false,
    lastGroupId: json["last_group_id"] ?? "",
    lastTaskOrder: json["last_task_order"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "enabled": enabled,
    "last_group_id": lastGroupId,
    "last_task_order": lastTaskOrder,
  };

  static UserModel get empty => UserModel(
    id: "",
    email: "",
    enabled: false,
    lastGroupId: "",
    lastTaskOrder: 0
  );
  
  UserModel copyWith ({
    String? id,
    String? email,
    bool? enabled,
    String? lastGroupId,
    int? lastTaskOrder,
  }) => UserModel(
    id: id?? this.id,
    email: email?? this.email,
    enabled: enabled?? this.enabled,
    lastGroupId: lastGroupId?? this.lastGroupId,
    lastTaskOrder: lastTaskOrder?? this.lastTaskOrder,
  );
}
