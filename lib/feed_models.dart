// Models for Instagram Home Feed

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

enum FeedItemType { post, carousel, ad, suggestedForYou }

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

class FeedPostModel {
  final FeedItemType type;
  final UserModel user;
  final List<String> imageUrls; // multiple for carousel
  final int likes;
  final int comments;
  final int reposts;
  final String? sendCount; // e.g. "51.7K"
  final String caption;
  final String timeAgo;
  final bool isAd;
  final bool isSuggestedForYou;
  final bool showInterestPrompt;
  final bool isLikedBy;
  final String? likedByUsername;
  final bool hasStory;
  final bool showFollow;

  const FeedPostModel({
    required this.type,
    required this.user,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    required this.reposts,
    this.sendCount,
    required this.caption,
    required this.timeAgo,
    this.isAd = false,
    this.isSuggestedForYou = false,
    this.showInterestPrompt = false,
    this.isLikedBy = false,
    this.likedByUsername,
    required this.hasStory,
    required this.showFollow,
  });
}

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
