import 'package:flutter/material.dart';
import 'package:insta_home/stories_bar.dart';
import 'package:insta_home/suggested_for_you_section.dart';

import 'feed_models.dart';
import 'feed_post.dart';
import 'instagram_bottom_nav.dart';
import 'instagram_top_bar.dart';
import 'mock_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const InstagramTopBar(),
      bottomNavigationBar: const InstagramBottomNav(),
      body: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount:
            1 + mockFeed.length, // 1 for stories row
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                StoriesBar(stories: mockStories),
                Divider(
                    color: const Color(0xFF262626),
                    thickness: 0.5,
                    height: 0),
              ],
            );
          }

          final feedItem = mockFeed[index - 1];

          if (feedItem.type == FeedItemType.suggestedForYou) {
            return SuggestedForYouSection(users: mockSuggestedUsers);
          }

          return FeedPost(post: feedItem);
        },
      ),
    );
  }
}
