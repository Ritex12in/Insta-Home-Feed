import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'feed_models.dart';

class SuggestedForYouSection extends StatelessWidget {
  final List<SuggestedUserModel> users;

  const SuggestedForYouSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Text(
                'Suggested for you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Color(0xFF0095F6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _SuggestedUserCard(user: users[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: const Color(0xFF262626), thickness: 0.5),
      ],
    );
  }
}

class _SuggestedUserCard extends StatefulWidget {
  final SuggestedUserModel user;
  const _SuggestedUserCard({required this.user});

  @override
  State<_SuggestedUserCard> createState() => _SuggestedUserCardState();
}

class _SuggestedUserCardState extends State<_SuggestedUserCard> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return Container(
      width: 166,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF363636), width: 0.5),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 86,
                  height: 86,
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
                    padding: const EdgeInsets.all(2.5),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.user.avatarUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, _) =>
                            Container(color: const Color(0xFF262626)),
                        errorWidget: (_, _, _) =>
                            Container(color: const Color(0xFF262626)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Mutuals or Suggested
                if (widget.user.mutuals > 0)
                  _MutualsRow(mutuals: widget.user.mutuals)
                else
                  const Text(
                    'Suggested for you',
                    style: TextStyle(
                      color: Color(0xFF8E8E8E),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 12),
                // Follow button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0095F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // X dismiss button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => setState(() => _dismissed = true),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _MutualsRow extends StatelessWidget {
  final int mutuals;
  const _MutualsRow({required this.mutuals});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Small overlapping avatars placeholder
        SizedBox(
          width: 44,
          height: 18,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF505050),
                    border: Border.all(color: const Color(0xFF1A1A1A), width: 1),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF606060),
                    border: Border.all(color: const Color(0xFF1A1A1A), width: 1),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF707070),
                    border: Border.all(color: const Color(0xFF1A1A1A), width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$mutuals mutuals',
          style: const TextStyle(
            color: Color(0xFF8E8E8E),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
