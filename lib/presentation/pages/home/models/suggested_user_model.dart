class SuggestedUserModel {
  final String username;
  final String avatarUrl;
  final int mutuals;
  final bool isSuggestedForYou;

  const SuggestedUserModel({
    required this.username,
    required this.avatarUrl,
    this.mutuals = 0,
    this.isSuggestedForYou = false,
  });
}
