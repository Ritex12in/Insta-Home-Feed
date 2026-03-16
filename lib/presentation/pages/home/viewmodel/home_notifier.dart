import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_home/domain/model/home_page_state.dart';

import '../../../../core/providers/app_providers.dart';

class HomeNotifier extends AsyncNotifier<HomePageState> {
  static const int _limit = 10;

  @override
  Future<HomePageState> build() async {
    final homeRepository = ref.watch(homeRepositoryProvider);
    await Future.delayed(Duration(milliseconds: 1500));
    final posts = await homeRepository.getPosts(_limit);
    final stories = await homeRepository.getStories(10);
    final suggestedUsers = await homeRepository.getSuggested(10);

    return HomePageState(
      posts: posts,
      stories: stories,
      suggestedUsers: suggestedUsers,
      page: 1,
      isLoadingMore: false,
      hasMore: posts.length == _limit,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null) return;

    if (currentState.isLoadingMore || !currentState.hasMore) return;

    state = AsyncData(
      currentState.copyWith(isLoadingMore: true),
    );

    try {
      final homeRepository = ref.read(homeRepositoryProvider);

      final nextPage = currentState.page + 1;

      final newPosts = await homeRepository.getPosts(
        _limit
      );

      final updatedPosts = [...currentState.posts, ...newPosts];

      state = AsyncData(
        currentState.copyWith(
          posts: updatedPosts,
          page: nextPage,
          isLoadingMore: false,
          hasMore: newPosts.length == _limit,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
      state = AsyncData(
        currentState.copyWith(isLoadingMore: false),
      );
    }
  }
}