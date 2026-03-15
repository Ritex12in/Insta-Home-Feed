import 'package:flutter/material.dart';

class PostActionsBar extends StatefulWidget {
  final int likes;
  final int comments;
  final int reposts;
  final String? sendCount;
  final bool isLikedBy;
  final String? likedByUsername;
  final String caption;
  final String username;
  final String timeAgo;
  final bool isAd;

  const PostActionsBar({
    super.key,
    required this.likes,
    required this.comments,
    required this.reposts,
    this.sendCount,
    this.isLikedBy = false,
    this.likedByUsername,
    required this.caption,
    required this.username,
    required this.timeAgo,
    this.isAd = false,
  });

  @override
  State<PostActionsBar> createState() => _PostActionsBarState();
}

class _PostActionsBarState extends State<PostActionsBar> {
  bool _isLiked = false;
  bool _isBookmarked = false;

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      final val = count / 1000;
      if (val == val.roundToDouble()) return '${val.round()}K';
      return '${val.toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final likeCount = widget.likes + (_isLiked ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action icons row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              // Like
              _ActionIcon(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : Colors.white,
                count: _formatCount(likeCount),
                onTap: () => setState(() => _isLiked = !_isLiked),
              ),
              const SizedBox(width: 4),
              // Comment
              _ActionIcon(
                icon: Icons.chat_bubble_outline,
                count: _formatCount(widget.comments),
                onTap: () {},
              ),
              const SizedBox(width: 4),
              // Repost
              _ActionIcon(
                icon: Icons.repeat,
                count: _formatCount(widget.reposts),
                onTap: () {},
              ),
              const SizedBox(width: 4),
              // Send (paper plane)
              _ActionIconCustom(
                count: widget.sendCount ?? '',
                onTap: () {},
              ),
              const Spacer(),
              // Bookmark
              GestureDetector(
                onTap: () => setState(() => _isBookmarked = !_isBookmarked),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Liked by
        if (widget.isLikedBy && widget.likedByUsername != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 4),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 13),
                children: [
                  const TextSpan(text: 'Liked by '),
                  TextSpan(
                    text: widget.likedByUsername,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(text: ' and others'),
                ],
              ),
            ),
          ),

        // Caption
        if (widget.caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                children: [
                  TextSpan(
                    text: widget.username,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: widget.caption),
                ],
              ),
            ),
          ),

        // Time ago
        if (widget.timeAgo.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4, bottom: 8),
            child: Text(
              widget.timeAgo,
              style: const TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.5,
              ),
            ),
          )
        else
          const SizedBox(height: 8),

        // Ad signup button
        if (widget.isAd)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0095F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String count;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    this.color = Colors.white,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Row(
          children: [
            Icon(icon, color: color, size: 26),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionIconCustom extends StatelessWidget {
  final String count;
  final VoidCallback onTap;

  const _ActionIconCustom({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Row(
          children: [
            // Paper plane icon (send)
            Transform.rotate(
              angle: -0.5,
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 5),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
