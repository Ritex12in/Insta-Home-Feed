import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'feed_models.dart';
import 'post_header.dart';
import 'post_actions_bar.dart';
import 'interest_prompt.dart';

class FeedPost extends StatefulWidget {
  final FeedPostModel post;

  const FeedPost({super.key, required this.post});

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  int _currentCarouselIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        PostHeader(
          user: post.user,
          isAd: post.isAd,
          isSuggestedForYou: post.isSuggestedForYou,
          showFollow: post.isSuggestedForYou,
        ),

        // Image(s)
        if (post.imageUrls.isNotEmpty) _buildImageSection(post),

        // Interest prompt (shown between image and actions)
        if (post.showInterestPrompt)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: InterestPrompt(),
          ),

        // Actions + caption
        PostActionsBar(
          likes: post.likes,
          comments: post.comments,
          reposts: post.reposts,
          sendCount: post.sendCount,
          isLikedBy: post.isLikedBy,
          likedByUsername: post.likedByUsername,
          caption: post.caption,
          username: post.user.username,
          timeAgo: post.timeAgo,
          isAd: post.isAd,
        ),

        // Ad: large signup button with right arrow
        if (post.isAd)
          _AdSignupRow(),

        // Divider
        Divider(color: const Color(0xFF262626), thickness: 0.5),
      ],
    );
  }

  Widget _buildImageSection(FeedPostModel post) {
    if (post.type == FeedItemType.carousel && post.imageUrls.length > 1) {
      return Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: post.imageUrls.length,
              onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: post.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, __) =>
                      Container(color: const Color(0xFF262626)),
                  errorWidget: (_, __, ___) =>
                      Container(color: const Color(0xFF262626)),
                );
              },
            ),
          ),
          // Slide counter (e.g. "2/4")
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentCarouselIndex + 1}/${post.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Mute icon (bottom right)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.volume_off,
                  color: Colors.white, size: 18),
            ),
          ),
          // Dot indicators (bottom center)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                post.imageUrls.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: i == _currentCarouselIndex ? 6 : 5,
                  height: i == _currentCarouselIndex ? 6 : 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _currentCarouselIndex
                        ? const Color(0xFF0095F6)
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Single image
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: post.imageUrls.first,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
          placeholder: (_, __) => Container(
            height: MediaQuery.of(context).size.width,
            color: const Color(0xFF262626),
          ),
          errorWidget: (_, __, ___) => Container(
            height: MediaQuery.of(context).size.width,
            color: const Color(0xFF262626),
          ),
        ),
        // Mute icon for video posts (shown on some)
        if (post.isSuggestedForYou)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.volume_off,
                  color: Colors.white, size: 18),
            ),
          ),
      ],
    );
  }
}

class _AdSignupRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF262626), width: 0.5),
          bottom: BorderSide(color: Color(0xFF262626), width: 0.5),
        ),
      ),
      child: ListTile(
        dense: true,
        title: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: () {},
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
