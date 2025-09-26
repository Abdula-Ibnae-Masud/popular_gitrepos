import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/repos_bloc.dart';
import '../../dio_init/dio_injector.dart' as dio;
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => dio.dioInitialize<ReposBloc>()..add(ReposFetched()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Popular GitRepos 'Android'"),
          centerTitle: true,
        ),
        body: BlocBuilder<ReposBloc, ReposState>(
          builder: (context, state) {
            if (state is ReposLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReposLoadSuccess) {
              final repos = state.repos;
              if (repos.isEmpty) {
                return const Center(child: Text('No repos cached yet'));
              }
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<ReposBloc>().add(ReposRefresh()),
                child: ListView.builder(
                  itemCount: repos.length,
                  itemBuilder: (context, index) {
                    final repo = repos[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: index % 2 == 0
                          ? Colors.transparent
                          : Colors.white60,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            repo.ownerAvatarUrl,
                          ),
                        ),
                        title: Text(repo.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(repo.ownerName),
                            Text(
                              repo.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star_border),
                            Text(repo.stars.toString()),
                          ],
                        ),
                        onTap: () =>
                            GoRouter.of(context).push('/details', extra: repo),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ReposLoadFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
