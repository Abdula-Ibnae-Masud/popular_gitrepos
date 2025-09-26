import 'package:equatable/equatable.dart';

class Repository extends Equatable {
  final int id;
  final String name;
  final String description;
  final String ownerName;
  final String ownerAvatarUrl;
  final int stars;
  final String htmlUrl;
  final DateTime updatedAt;

  const Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.stars,
    required this.htmlUrl,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, ownerName, stars];
}
