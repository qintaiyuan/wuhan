extension SortedQueryString on Map<String, String> {
  String toSortedQueryString() {
    if (isEmpty) return '';
    final sortedEntries = entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final queryString = sortedEntries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    return queryString;
  }
}

extension PhoneNumberFormatter on String {
  String formatPhoneNumber() {
    if (length != 11) {
      throw ArgumentError('Invalid phone number length. Expected length is 11.');
    }

    String start = substring(0, 3);
    String end = substring(7);

    return '$start****$end';
  }
}