
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.enabled,
  });

  final String id;
  final String email;
  final bool enabled;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    enabled: json["enabled"]?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "enabled": enabled,
  };

  static UserModel get empty => UserModel(
    id: "",
    email: "",
    enabled: false,
  );
  
  UserModel copyWith ({
    String? id,
    String? email,
    bool? enabled,
  }) => UserModel(
    id: id?? this.id,
    email: email?? this.email,
    enabled: enabled?? this.enabled,
  );
}
