part of 'repos_bloc.dart';

abstract class ReposEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReposFetched extends ReposEvent {}

class ReposRefresh extends ReposEvent {}
