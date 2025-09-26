import '../repositories/repository.dart';

class RepositoryModel extends Repository {
  const RepositoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.ownerName,
    required super.ownerAvatarUrl,
    required super.stars,
    required super.htmlUrl,
    required super.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'] as int,
      name: (json['name'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      ownerName: (json['owner']?['login'] ?? '') as String,
      ownerAvatarUrl: (json['owner']?['avatar_url'] ?? '') as String,
      stars: (json['stargazers_count'] ?? 0) as int,
      htmlUrl: (json['html_url'] ?? '') as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  factory RepositoryModel.fromDb(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      ownerName: map['owner_name'] as String,
      ownerAvatarUrl: map['owner_avatar'] as String,
      stars: map['stars'] as int,
      htmlUrl: map['html_url'] as String,
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'owner_name': ownerName,
      'owner_avatar': ownerAvatarUrl,
      'stars': stars,
      'html_url': htmlUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
