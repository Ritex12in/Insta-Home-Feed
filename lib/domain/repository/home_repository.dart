import 'package:insta_home/feed_models.dart';

abstract class HomeRepository {
  Future<List<FeedPostModel>> getPosts(int perPage);
  Future<List<StoryModel>> getStories(int count);
  Future<List<SuggestedUserModel>> getSuggested(int count);
}