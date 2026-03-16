import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_home/data/datasource/insta_datasource.dart';

import '../../data/domain/repository/home_repository_impl.dart';
import '../../domain/model/home_page_state.dart';
import '../../domain/repository/home_repository.dart';
import '../../presentation/pages/home/home_notifier.dart';

final instaDataSourceProvider = Provider<InstaDatasource>((ref){
  return InstaDatasource();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref){
  final datasource = ref.watch(instaDataSourceProvider);
  return HomeRepositoryImpl(datasource);
});

final homeNotifierProvider = AsyncNotifierProvider<HomeNotifier, HomePageState>(HomeNotifier.new);