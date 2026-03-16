import 'dart:math';
import '../../../domain/repository/home_repository.dart';
import '../../../presentation/pages/home/models/feed_item.dart';
import '../../../presentation/pages/home/models/feed_post_model.dart';
import '../../../presentation/pages/home/models/story_model.dart';
import '../../../presentation/pages/home/models/suggested_user_model.dart';
import '../../../presentation/pages/home/models/user_model.dart';
import '../../datasource/insta_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final InstaDatasource datasource;

  final _random = Random();

  HomeRepositoryImpl(this.datasource);

  @override
  Future<List<FeedPostModel>> getPosts(int perPage) async {
    List<FeedPostModel> posts = [];
    for (int i = 0; i < perPage; i++) {
      final imageUrl = await datasource.getImageUrl(_random.nextInt(2000)+1);
      FeedItemType type = _getRandomFeedType(_random.nextInt(100));
      posts.add(
        FeedPostModel(
          type: type,
          user: UserModel(
            username: _getRandomUsername(),
            avatarUrl: await datasource.getImageUrl(_random.nextInt(2000)+1),
          ),
          imageUrls: type == FeedItemType.carousel
              ? await _getImageUrls(6)
              : [imageUrl],
          likes: _random.nextInt(100000),
          comments: _random.nextInt(10000),
          reposts: _random.nextInt(10000),
          caption: _getRandomCaption(),
          isAd: type == FeedItemType.ad,
          isSuggestedForYou: type == FeedItemType.suggestedForYou,
          showInterestPrompt: _random.nextBool() && type == FeedItemType.post,
          isLikedBy: _random.nextBool(),
          likedByUsername: _getRandomUsername(),
          timeAgo: _getRandomTimeAgo(),
          hasStory: _random.nextBool(),
          showFollow: _random.nextBool(),
        ),
      );
    }

    return posts;
  }

  @override
  Future<List<StoryModel>> getStories(int count) async {
    final List<StoryModel> stories = [];
    stories.add(
      StoryModel(
        username: 'Your story',
        avatarUrl: await datasource.getImageUrl(1),
        isOwn: true,
      ),
    );
    for (int i = 0; i < count; i++) {
      stories.add(
        StoryModel(
          username: _getRandomUsername(),
          avatarUrl: await datasource.getImageUrl(i + 400),
          isSeen: _random.nextBool(),
        ),
      );
    }
    return stories;
  }

  @override
  Future<List<SuggestedUserModel>> getSuggested(int count) async {
    final List<SuggestedUserModel> suggested = [];
    for (int i = 0; i < count; i++) {
      suggested.add(
        SuggestedUserModel(
          username: _getRandomUsername(),
          avatarUrl: await datasource.getImageUrl(_random.nextInt(2000)+1),
          mutuals: _random.nextInt(4),
        ),
      );
    }
    return suggested;
  }

  FeedItemType _getRandomFeedType(int n) {
    if (n < 30) return FeedItemType.post;
    if (n < 60) return FeedItemType.carousel;
    if (n < 75) return FeedItemType.ad;
    return FeedItemType.suggestedForYou;
  }

  Future<List<String>> _getImageUrls(int n) async {
    final List<String> urls = [];
    for (int i = 0; i < n; i++) {
      urls.add(await datasource.getImageUrl(_random.nextInt(2000)+1));
    }
    return urls;
  }

  String _getRandomUsername() {
    const adjectives = [
      'cool',
      'urban',
      'silent',
      'wild',
      'lazy',
      'happy',
      'epic',
      'dark',
      'golden',
      'real',
      'official',
      'daily',
      'crazy',
      'frozen',
      'rapid',
    ];

    const nouns = [
      'rider',
      'vibes',
      'traveler',
      'soul',
      'dreamer',
      'boy',
      'girl',
      'king',
      'queen',
      'world',
      'artist',
      'tiger',
      'eagle',
      'star',
      'wave',
    ];

    final adjective = adjectives[_random.nextInt(adjectives.length)];
    final noun = nouns[_random.nextInt(nouns.length)];
    final number = _random.nextInt(9999);

    return '$adjective$noun$number';
  }

  String _getRandomCaption() {
    const captions = [
      'Just another day, just another vibe ✨',
      'Living the moment 🌸',
      'No caption needed 😌',
      'Chasing dreams and sunsets 🌅',
      'Good vibes only 💫',
      'A little progress every day.',
      'Smiling through it all 😄',
      'This felt nice.',
      'Caught in the moment 📸',
      'Peace. Coffee. Repeat. ☕',
      'Somewhere between chaos and calm.',
      'Memories in the making ❤️',
      'Less perfection, more authenticity.',
      'Weekend energy 😎',
      'Tiny moments, big memories.',
    ];

    return captions[_random.nextInt(captions.length)];
  }

  String _getRandomTimeAgo() {
    final type = _random.nextInt(4);

    switch (type) {
      case 0:
        final minutes = _random.nextInt(59) + 1;
        return '$minutes minute${minutes > 1 ? 's' : ''} ago';

      case 1:
        final hours = _random.nextInt(23) + 1;
        return '$hours hour${hours > 1 ? 's' : ''} ago';

      case 2:
        final days = _random.nextInt(7) + 1;
        return '$days day${days > 1 ? 's' : ''} ago';

      default:
        final weeks = _random.nextInt(4) + 1;
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
    }
  }
}
