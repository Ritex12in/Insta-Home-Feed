import 'package:insta_home/feed_models.dart';

class HomePageState {
  final List<FeedPostModel> posts;
  final List<StoryModel> stories;
  final List<SuggestedUserModel> suggestedUsers;
  final int page;
  final bool isLoadingMore;
  final bool hasMore;

  HomePageState({
    required this.posts,
    required this.stories,
    required this.suggestedUsers,
    this.page = 1,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  HomePageState copyWith({
    List<FeedPostModel>? posts,
    List<StoryModel>? stories,
    List<SuggestedUserModel>? suggestedUsers,
    int? page,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return HomePageState(
      posts: posts ?? this.posts,
      stories: stories ?? this.stories,
      suggestedUsers: suggestedUsers ?? this.suggestedUsers,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}