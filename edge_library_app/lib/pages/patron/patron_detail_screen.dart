import 'package:edge_library_app/entities/book/widgets/book_list_tile.dart';
import 'package:edge_library_app/entities/patron/model/patron.dart';
import 'package:edge_library_app/routing/router.dart';
import 'package:edge_library_app/shared/api/identity/identity_facade.dart';
import 'package:edge_library_app/shared/extensions/build_context.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PatronDetailScreen extends ConsumerWidget {
  const PatronDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patronAsync = ref.watch(patronProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          TextButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              await ref.read(identityFacadeProvider).signOut();
              ref.invalidate(currentUserProvider);
              if (context.mounted) context.go('/');
            },
          )
        ],
      ),
      body: patronAsync.when(
        data: PatronDetailDataView.new,
        error: PatronDetailErrorView.new,
        loading: PatronDetailLoadingView.new,
      ),
    );
  }
}

class PatronDetailLoadingView extends StatelessWidget {
  @visibleForTesting
  const PatronDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PatronDetailErrorView extends StatelessWidget {
  @visibleForTesting
  const PatronDetailErrorView(this.error, this.stackTrace, {super.key});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PatronDetailDataView extends StatelessWidget {
  @visibleForTesting
  const PatronDetailDataView(this.data, {super.key});

  final Patron? data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (data?.name != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(data!.name!, style: context.textTheme.displaySmall),
            ),
          ),
        if (data?.email != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(data!.email!,
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.grey)),
            ),
          ),
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(),
        )),
        const SliverGap(32),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Borrowed books', style: context.textTheme.titleLarge),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final book = data!.borrowed[index];

              return BookListTile(
                book: book,
                onTap: () => context.go('/books/${book.id}'),
              );
            },
            childCount: data?.borrowed.length ?? 0,
          ),
        ),
      ],
    );
  }
}
