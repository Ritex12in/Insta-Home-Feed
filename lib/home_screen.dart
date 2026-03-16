import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_home/core/providers/app_providers.dart';
import 'package:insta_home/stories_bar.dart';
import 'package:insta_home/suggested_for_you_section.dart';
import 'feed_post.dart';
import 'instagram_bottom_nav.dart';
import 'instagram_top_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isPaginationCalled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Trigger when user reaches near bottom
    if (currentScroll >= maxScroll - 200) {
      if (!_isPaginationCalled) {
        _isPaginationCalled = true;
        ref.read(homeNotifierProvider.notifier).loadMore();
      }
    } else {
      _isPaginationCalled = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifierProvider);

    return state.when(
      data: (data) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: const InstagramTopBar(),
          bottomNavigationBar: const InstagramBottomNav(),
          body: SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      StoriesBar(stories: data.stories),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, idx) {
                      final feedItem = data.posts[idx];
                      return FeedPost(post: feedItem);
                    },
                    childCount: data.posts.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SuggestedForYouSection(users: data.suggestedUsers),
                ),

                if(data.page>1)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, idx) {
                        final feedItem = data.posts[idx];
                        return FeedPost(post: feedItem);
                      },
                      childCount: data.posts.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}