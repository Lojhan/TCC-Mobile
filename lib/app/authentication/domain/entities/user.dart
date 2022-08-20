class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  Map<String, String> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  static fromJson(Map<String, String>? json) {
    if (json == null) {
      return null;
    }
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }
}
