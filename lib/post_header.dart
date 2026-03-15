import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'feed_models.dart';


class PostHeader extends StatelessWidget {
  final UserModel user;
  final bool isAd;
  final bool isSuggestedForYou;
  final bool showFollow;
  final bool hasStory;
  final bool isReel;

  const PostHeader({
    super.key,
    required this.user,
    this.isAd = false,
    this.isReel = true,
    this.isSuggestedForYou = false,
    this.showFollow = false,
    this.hasStory = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Avatar
          _buildAvatar(),
          const SizedBox(width: 10),
          // Username + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (user.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF0095F6),
                        size: 14,
                      ),
                    ],
                  ],
                ),
                if (isAd)
                  const Text(
                    'Ad',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                else if (isSuggestedForYou)
                  const Text(
                    'Suggested for you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
          // Follow button (for suggested/ad)
          if (showFollow || isSuggestedForYou) ...[
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isReel?Colors.transparent : Colors.white.withValues(alpha: 0.15),
                side: BorderSide(color: isReel? Colors.white : Color(0xFF363636), width: 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          // 3 dots
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(Icons.more_vert, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if(hasStory) {
      return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFD600),
            Color(0xFFFF7A00),
            Color(0xFFFF0069),
            Color(0xFFD300C5),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.avatarUrl,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(color: const Color(0xFF262626)),
            errorWidget: (_, _, _) =>
                Container(color: const Color(0xFF262626)),
          ),
        ),
      ),
    );
    }else{
      return SizedBox(
        height: 34,
        width: 34,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.avatarUrl,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(color: const Color(0xFF262626)),
            errorWidget: (_, _, _) =>
                Container(color: const Color(0xFF262626)),
          ),
        ),
      );
    }
  }
}
