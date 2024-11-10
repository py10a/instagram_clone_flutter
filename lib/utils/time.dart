/// Get date in a human-readable format from the given [date]
///
///   - if today, then '2 hours ago'
///   - if this week, then '2 days ago'
///   - else 'May 1, 2021'
///
String getHumanReadableDate(DateTime date) {
  final DateTime now = DateTime.now();
  final Duration diff = now.difference(date);

  switch (diff.inDays) {
    case 0:
      return diff.inHours == 0
          ? diff.inMinutes == 0
              ? 'Just now'
              : '${diff.inMinutes} minutes ago'
          : '${diff.inHours} hours ago';
    default:
      return diff.inDays < 7
          ? '${diff.inDays} days ago'
          : '${date.month}/${date.day}/${date.year}';
  }
}
