

import 'feed_models.dart';

const String _imgBase = 'https://yavuzceliker.github.io/sample-images/image-';

String img(int n) => '$_imgBase$n.jpg';

final List<StoryModel> mockStories = [
  StoryModel(
    username: 'Your story',
    avatarUrl: img(1),
    isOwn: true,
  ),
  StoryModel(username: '_ashiii_55', avatarUrl: img(2)),
  StoryModel(username: 'shreeyanshkumar', avatarUrl: img(3)),
  StoryModel(username: 'prince_tiwa', avatarUrl: img(4)),
  StoryModel(username: 'raman.bh', avatarUrl: img(5), isSeen: true),
  StoryModel(username: 'dev.studio', avatarUrl: img(6)),
  StoryModel(username: 'travel_23', avatarUrl: img(7)),
  StoryModel(username: 'foodie.in', avatarUrl: img(8)),
];

final List<SuggestedUserModel> mockSuggestedUsers = [
  SuggestedUserModel(
    username: 'Amitsingh',
    avatarUrl: img(20),
    mutuals: 3,
  ),
  SuggestedUserModel(
    username: 'Cătălina Dasc',
    avatarUrl: img(21),
    mutuals: 1,
  ),
  SuggestedUserModel(
    username: 'Freyja',
    avatarUrl: img(22),
    isSuggestedForYou: true,
  ),
  SuggestedUserModel(
    username: 'Mutlu Mar',
    avatarUrl: img(23),
    isSuggestedForYou: true,
  ),
];

final List<FeedPostModel> mockFeed = [
  // Post 1 - regular post with interest prompt
  FeedPostModel(
    type: FeedItemType.post,
    user: UserModel(
      username: '_manalisharma_',
      avatarUrl: img(30),
    ),
    imageUrls: [img(31)],
    likes: 47400,
    comments: 546,
    reposts: 428,
    sendCount: '51.7K',
    caption: 'Mehangi vali lena haaaa............',
    timeAgo: '1 day ago',
    showInterestPrompt: true,
  ),

  // Post 2 - Genshin Impact post
  FeedPostModel(
    type: FeedItemType.post,
    user: UserModel(
      username: 'genshinimpact',
      avatarUrl: img(40),
      isVerified: true,
    ),
    imageUrls: [img(41)],
    likes: 14800,
    comments: 386,
    reposts: 1896,
    caption: '🍺 Ha, perfect timing! Hey, buddy,...',
    timeAgo: '41 minutes ago',
  ),

  // Suggested for you section
  FeedPostModel(
    type: FeedItemType.suggestedForYou,
    user: UserModel(username: '', avatarUrl: ''),
    imageUrls: [],
    likes: 0,
    comments: 0,
    reposts: 0,
    caption: '',
    timeAgo: '',
  ),

  // Post 3 - Cricket viral post with interest prompt
  FeedPostModel(
    type: FeedItemType.post,
    user: UserModel(
      username: 'buzzpostindia',
      avatarUrl: img(50),
    ),
    imageUrls: [img(51)],
    likes: 399000,
    comments: 5138,
    reposts: 2238,
    sendCount: '113K',
    caption: 'A bizarre moment from the matc...',
    timeAgo: '13 hours ago',
    showInterestPrompt: true,
    isLikedBy: true,
    likedByUsername: 'raman.bhardwaj_',
  ),

  // Post 4 - fact.server_ post
  FeedPostModel(
    type: FeedItemType.post,
    user: UserModel(
      username: 'fact.server_',
      avatarUrl: img(60),
    ),
    imageUrls: [img(61)],
    likes: 0,
    comments: 0,
    reposts: 0,
    caption: 'fact.server_ • Original audio',
    timeAgo: '',
    isSuggestedForYou: true,
  ),

  // Ad - MongoDB
  FeedPostModel(
    type: FeedItemType.ad,
    user: UserModel(
      username: 'mongodb',
      avatarUrl: img(70),
      isVerified: true,
    ),
    imageUrls: [img(71)],
    likes: 189,
    comments: 0,
    reposts: 0,
    sendCount: '1',
    caption:
        "Think cramming JSON in a table is good enough? Think again. Today's apps need rich data... more",
    timeAgo: '',
    isAd: true,
  ),

  // Carousel post - instantbollywood (Pakistan cricket)
  FeedPostModel(
    type: FeedItemType.carousel,
    user: UserModel(
      username: 'instantbollywood',
      avatarUrl: img(80),
      isVerified: true,
    ),
    imageUrls: [img(81), img(82), img(83), img(84)],
    likes: 140000,
    comments: 5030,
    reposts: 647,
    sendCount: '23.5K',
    caption: 'A section of fans has called...',
    timeAgo: '23 hours ago',
    isSuggestedForYou: true,
  ),

  // berozgaar_podcast post (suggested)
  FeedPostModel(
    type: FeedItemType.post,
    user: UserModel(
      username: 'berozgaar_podcast',
      avatarUrl: img(90),
      isVerified: true,
    ),
    imageUrls: [img(91)],
    likes: 0,
    comments: 0,
    reposts: 0,
    caption: '',
    timeAgo: '',
    isSuggestedForYou: true,
  ),

  // Ad - pygmalion silicone factory
  FeedPostModel(
    type: FeedItemType.ad,
    user: UserModel(
      username: 'pygmalion_doll8',
      avatarUrl: img(100),
    ),
    imageUrls: [img(101)],
    likes: 97800,
    comments: 1821,
    reposts: 3032,
    sendCount: '236K',
    caption:
        'Daily Operations at a Silicone Factory #realdoll #siliconedoll #customdoll #dollfactory #dolls',
    timeAgo: 'December 15, 2025',
    isAd: false,
  ),
];

String formatCount(int count) {
  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M';
  } else if (count >= 1000) {
    final val = count / 1000;
    if (val == val.roundToDouble()) {
      return '${val.round()}K';
    }
    return '${val.toStringAsFixed(1)}K';
  }
  return count.toString();
}
