import 'package:edge_library_app/shared/extensions/build_context.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class BookSummaryView extends StatelessWidget {
  const BookSummaryView({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ExpandedScrollingColumn(
      scrollViewBuilder: (direction, child) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: child,
          ),
        ),
      ),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(book.author, style: context.textTheme.titleLarge),
        Text(book.title, style: context.textTheme.titleMedium),
        const Gap(16),
        Text(book.description),
        const Gap(16),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RELEASE',
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey)),
                Text(DateFormat.yMMMd().format(book.publicationDate),
                    style: context.textTheme.labelSmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('GENRE',
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey)),
                Text(book.genre, style: context.textTheme.labelSmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('COPIES',
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey)),
                Text(book.copies.toString(),
                    style: context.textTheme.labelSmall),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
