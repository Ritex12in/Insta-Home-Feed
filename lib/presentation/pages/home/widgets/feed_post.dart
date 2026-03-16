import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/feed_item.dart';
import '../models/feed_post_model.dart';
import 'post_header.dart';
import 'post_actions_bar.dart';
import 'interest_prompt.dart';
import 'pinch_zoom_overlay.dart';

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
        if (post.isAd || post.imageUrls.length > 1)
          PostHeader(
            user: post.user,
            isAd: post.isAd,
            isSuggestedForYou: post.isSuggestedForYou,
            showFollow: post.showFollow,
            hasStory: post.hasStory,
          ),

        // Image(s) — wrapped with pinch-to-zoom
        if (post.imageUrls.isNotEmpty) _buildImageSection(post),

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

        // Interest prompt
        if (post.showInterestPrompt)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: InterestPrompt(),
          ),

        const SizedBox(height: 4.0),
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
                return PinchZoomOverlay(
                  imageUrl: post.imageUrls[index],
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, _) =>
                        Container(color: const Color(0xFF262626)),
                    errorWidget: (_, _, _) =>
                        Container(color: const Color(0xFF262626)),
                  ),
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
                color: Colors.black.withValues(alpha: 0.6),
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
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_off,
                color: Colors.white,
                size: 18,
              ),
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
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Single image — wrapped with PinchZoomOverlay
    return Stack(
      children: [
        PinchZoomOverlay(
          imageUrl: post.imageUrls.first,
          child: AspectRatio(
            aspectRatio: post.isAd ? 3 / 4 : 9 / 16,
            child: CachedNetworkImage(
              imageUrl: post.imageUrls.first,
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.width,
              placeholder: (_, _) => Container(
                height: MediaQuery.of(context).size.width,
                color: const Color(0xFF262626),
              ),
              errorWidget: (_, _, _) => Container(
                height: MediaQuery.of(context).size.width,
                color: const Color(0xFF262626),
              ),
            ),
          ),
        ),
        // Mute icon for suggested posts
        if (post.isSuggestedForYou)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_off,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

        if (post.isAd)
          Positioned(bottom: 0, left: 0, right: 0, child: _AdSignupRow()),

        if (!post.isAd)
          PostHeader(
            user: post.user,
            isAd: post.isAd,
            isSuggestedForYou: post.isSuggestedForYou,
            showFollow: post.showFollow,
            hasStory: post.hasStory,
          ),
      ],
    );
  }
}

class _AdSignupRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
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