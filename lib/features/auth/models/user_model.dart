
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.enabled,
    required this.lastGroupId,
    required this.fcmToken
  });

  final String id;
  final String email;
  final bool enabled;
  final String lastGroupId;
  final String fcmToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    enabled: json["enabled"]?? false,
    lastGroupId: json["last_group_id"] ?? "",
    fcmToken: json["fcm_token"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "enabled": enabled,
    "last_group_id": lastGroupId,
    "fcm_token": fcmToken
  };

  static UserModel get empty => UserModel(
    id: "",
    email: "",
    enabled: false,
    lastGroupId: "",
    fcmToken: ""
  );
  
  UserModel copyWith ({
    String? id,
    String? email,
    bool? enabled,
    String? lastGroupId,
    String? fcmToken
  }) => UserModel(
    id: id?? this.id,
    email: email?? this.email,
    enabled: enabled?? this.enabled,
    lastGroupId: lastGroupId?? this.lastGroupId,
    fcmToken: fcmToken?? this.fcmToken,
  );
}
