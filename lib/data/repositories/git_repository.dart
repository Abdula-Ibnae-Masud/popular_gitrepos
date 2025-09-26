import 'repository.dart';

abstract class GitRepository {
  Future<List<Repository>> fetchTopRepos({int page = 1});
}
