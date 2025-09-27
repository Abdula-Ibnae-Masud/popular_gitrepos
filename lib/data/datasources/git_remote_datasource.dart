import 'package:dio/dio.dart';
import '../models/repository_model.dart';

class GitRemoteDataSource {
  final Dio client;
  static const _base = 'https://api.github.com';

  GitRemoteDataSource({required this.client});

  Future<List<RepositoryModel>> searchInRepository({
    required String query,
    int page = 1,
    int perPage = 30,
  }) async {
    final url = '$_base/search/repositories';

    final response = await client.get(
      url,
      queryParameters: {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
        'page': page,
        'per_page': perPage,
      },
    );

    final status = response.statusCode ?? 0;
    if (status == 200) {
      final jsonMap = response.data as Map<String, dynamic>;
      final items = (jsonMap['items'] as List<dynamic>);
      return items
          .map((e) => RepositoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch from GitHub: $status');
    }
  }
}
