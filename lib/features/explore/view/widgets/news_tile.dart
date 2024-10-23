import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class NewsTile extends StatelessWidget with IntlFormats {
  const NewsTile.expanded({
    super.key,
    required this.headlineTitle,
    required this.publication,
    required this.publishedAt,
    required this.imageUrl,
    this.onTap,
  }) : isExpanded = true;

  const NewsTile.collapsed({
    super.key,
    required this.headlineTitle,
    required this.publication,
    required this.publishedAt,
    required this.imageUrl,
    this.onTap,
  }) : isExpanded = false;

  final String headlineTitle;
  final String publication;
  final DateTime publishedAt;
  final String imageUrl;
  final VoidCallback? onTap;

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final tileContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headlineTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.regular
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        Constants.smallVerticalGutter.verticalSpace,
        DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .regular
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          child: Text(
            '$publication • ${_timeAgo(publishedAt)}',
          ),
        )
      ],
    );

    return InkWell(
      onTap: onTap,
      child: () {
        if (isExpanded) {
          return SizedBox(
            height: 268,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 166,
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Constants.verticalGutter.verticalSpace,
                tileContent,
              ],
            ),
          );
        }
        return SizedBox(
          height: 97,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 55,
                height: 73,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Constants.horizontalGutter.horizontalSpace,
              Expanded(child: tileContent),
            ],
          ),
        );
      }(),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) {
      return '${difference.inDays % 7}w';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }
}
