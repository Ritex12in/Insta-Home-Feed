import 'package:insta_home/presentation/pages/home/models/user_model.dart';
import 'feed_item.dart';

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