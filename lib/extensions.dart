extension SortedQueryString on Map<String, String> {
  String toSortedQueryString() {
    if (isEmpty) return '';
    final sortedEntries = entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final queryString = sortedEntries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    return queryString;
  }
}
