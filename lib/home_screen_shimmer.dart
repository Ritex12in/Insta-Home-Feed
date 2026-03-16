import 'package:flutter/material.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({super.key});

  @override
  State<HomeScreenShimmer> createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StoriesShimmer(animation: _animation),
                  const SizedBox(height: 4),
                  _FeedPostShimmer(animation: _animation),
                  _FeedPostShimmer(animation: _animation),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Stories Row ────────────────────────────────────────────────────────────

class _StoriesShimmer extends StatelessWidget {
  final Animation<double> animation;
  const _StoriesShimmer({required this.animation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                // Circle avatar
                _ShimmerBox(
                  animation: animation,
                  width: 66,
                  height: 66,
                  borderRadius: 33,
                ),
                const SizedBox(height: 6),
                // Username label
                _ShimmerBox(
                  animation: animation,
                  width: 52,
                  height: 10,
                  borderRadius: 4,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Feed Post ───────────────────────────────────────────────────────────────

class _FeedPostShimmer extends StatelessWidget {
  final Animation<double> animation;
  const _FeedPostShimmer({required this.animation});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post header: avatar + username + follow button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _ShimmerBox(
                animation: animation,
                width: 38,
                height: 38,
                borderRadius: 19,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(
                    animation: animation,
                    width: 120,
                    height: 12,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 6),
                  _ShimmerBox(
                    animation: animation,
                    width: 80,
                    height: 10,
                    borderRadius: 4,
                  ),
                ],
              ),
              const Spacer(),
              _ShimmerBox(
                animation: animation,
                width: 72,
                height: 30,
                borderRadius: 8,
              ),
            ],
          ),
        ),

        // Post image
        _ShimmerBox(
          animation: animation,
          width: screenWidth,
          height: screenWidth * (16 / 9),
          borderRadius: 0,
        ),

        // Action icons row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              _ShimmerBox(animation: animation, width: 26, height: 26, borderRadius: 4),
              const SizedBox(width: 16),
              _ShimmerBox(animation: animation, width: 26, height: 26, borderRadius: 4),
              const SizedBox(width: 16),
              _ShimmerBox(animation: animation, width: 26, height: 26, borderRadius: 4),
              const SizedBox(width: 16),
              _ShimmerBox(animation: animation, width: 26, height: 26, borderRadius: 4),
              const Spacer(),
              _ShimmerBox(animation: animation, width: 22, height: 26, borderRadius: 4),
            ],
          ),
        ),

        // Likes count
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 6),
          child: _ShimmerBox(animation: animation, width: 100, height: 11, borderRadius: 4),
        ),

        // Caption line 1
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 5),
          child: _ShimmerBox(animation: animation, width: screenWidth * 0.75, height: 11, borderRadius: 4),
        ),

        // Caption line 2
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 10),
          child: _ShimmerBox(animation: animation, width: screenWidth * 0.5, height: 11, borderRadius: 4),
        ),
      ],
    );
  }
}

// ─── Core shimmer box ────────────────────────────────────────────────────────

class _ShimmerBox extends StatelessWidget {
  final Animation<double> animation;
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.animation,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(animation.value - 1, 0),
                  end: Alignment(animation.value + 1, 0),
                  colors: const [
                    Color(0xFF1A1A1A),
                    Color(0xFF2E2E2E),
                    Color(0xFF3A3A3A),
                    Color(0xFF2E2E2E),
                    Color(0xFF1A1A1A),
                  ],
                  stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}