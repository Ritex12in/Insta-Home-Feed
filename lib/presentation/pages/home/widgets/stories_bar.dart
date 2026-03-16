import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/story_model.dart';

class StoriesBar extends StatelessWidget {
  final List<StoryModel> stories;

  const StoriesBar({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _StoryItem(story: stories[index]);
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final StoryModel story;

  const _StoryItem({required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatar(),
          const SizedBox(height: 4),
          SizedBox(
            width: 66,
            child: Text(
              story.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (story.isOwn) {
      return Stack(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF262626), width: 2),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: story.avatarUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: const Color(0xFF262626)),
                errorWidget: (_, _, _) => Container(color: const Color(0xFF262626)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      );
    }

    // Gradient ring for unread stories
    if (!story.isSeen) {
      return Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD600),
              Color(0xFFFF7A00),
              Color(0xFFFF0069),
              Color(0xFFD300C5),
              Color(0xFF7638FA),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: story.avatarUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: const Color(0xFF262626)),
                errorWidget: (_, _, _) => Container(color: const Color(0xFF262626)),
              ),
            ),
          ),
        ),
      );
    }

    // Seen story - grey ring
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF555555), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: story.avatarUrl,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(color: const Color(0xFF262626)),
            errorWidget: (_, _, _) => Container(color: const Color(0xFF262626)),
          ),
        ),
      ),
    );
  }
}
