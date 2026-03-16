class UserModel {
  final String username;
  final String avatarUrl;
  final bool isVerified;

  const UserModel({
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
  });
}