class StoryModel {
  final String username;
  final String avatarUrl;
  final bool isOwn;
  final bool isSeen;

  const StoryModel({
    required this.username,
    required this.avatarUrl,
    this.isOwn = false,
    this.isSeen = false,
  });
}