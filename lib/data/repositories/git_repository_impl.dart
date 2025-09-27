import 'repository.dart';
import 'git_repository.dart';
import '../datasources/git_local_datasource.dart';
import '../datasources/git_remote_datasource.dart';
import '../../core/network/network_info.dart';

class GitRepositoryImpl implements GitRepository {
  final GitRemoteDataSource remote;
  final GitLocalDataSource local;
  final CheckInternetConnection networkInfo;

  GitRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<List<Repository>> fetchTopRepos({int page = 1}) async {
    final isOnline = await networkInfo.isConnected;
    if (isOnline) {
      try {
        final remoteList = await remote.searchInRepository(
          query: 'Android',
          page: page,
        );
        await local.upsertRepos(remoteList);
        return remoteList;
      } catch (e) {
        final cached = await local.getAllRepos();
        if (cached.isNotEmpty) return cached;
        rethrow;
      }
    } else {
      // offline
      final cached = await local.getAllRepos();
      return cached;
    }
  }
}
