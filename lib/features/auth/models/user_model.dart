
class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.enabled,
  });

  final String uid;
  final String email;
  final bool enabled;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"] ?? "",
    email: json["email"] ?? "",
    enabled: json["enabled"]?? false,
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "enabled": enabled,
  };

  static UserModel get empty => UserModel(
    uid: "",
    email: "",
    enabled: false,
  );
  
  UserModel copyWith ({
    String? uid,
    String? email,
    bool? enabled,
  }) => UserModel(
    uid: uid?? this.uid,
    email: email?? this.email,
    enabled: enabled?? this.enabled,
  );
}
