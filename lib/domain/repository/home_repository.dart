import '../../presentation/pages/home/models/feed_post_model.dart';
import '../../presentation/pages/home/models/story_model.dart';
import '../../presentation/pages/home/models/suggested_user_model.dart';

abstract class HomeRepository {
  Future<List<FeedPostModel>> getPosts(int perPage);
  Future<List<StoryModel>> getStories(int count);
  Future<List<SuggestedUserModel>> getSuggested(int count);
}