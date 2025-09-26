import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/repository.dart';
import '../../data/repositories/git_repository.dart';

part 'repos_event.dart';
part 'repos_state.dart';

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final GitRepository repository;
  int _page = 1;

  ReposBloc(this.repository) : super(ReposInitial()) {
    on<ReposFetched>((event, emit) async {
      emit(ReposLoadInProgress());
      try {
        _page = 1;
        final repos = await repository.fetchTopRepos(page: _page);
        emit(ReposLoadSuccess(repos: repos));
      } catch (e) {
        emit(ReposLoadFailure(message: e.toString()));
      }
    });

    on<ReposRefresh>((event, emit) async {
      try {
        _page = 1;
        final repos = await repository.fetchTopRepos(page: _page);
        emit(ReposLoadSuccess(repos: repos));
      } catch (e) {
        emit(ReposLoadFailure(message: e.toString()));
      }
    });
  }
}
