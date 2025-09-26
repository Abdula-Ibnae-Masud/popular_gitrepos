part of 'repos_bloc.dart';

abstract class ReposState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReposInitial extends ReposState {}

class ReposLoadInProgress extends ReposState {}

class ReposLoadSuccess extends ReposState {
  final List<Repository> repos;

  ReposLoadSuccess({required this.repos});

  @override
  List<Object?> get props => [repos];
}

class ReposLoadFailure extends ReposState {
  final String message;
  ReposLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
