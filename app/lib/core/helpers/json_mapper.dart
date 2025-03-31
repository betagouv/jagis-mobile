class JsonListMapper<T> {
  const JsonListMapper._();

  static List<T> fromJsonList<T>(final dynamic jsonList, final T Function(Map<String, dynamic>) fromJson) =>
      (jsonList as List<dynamic>).cast<Map<String, dynamic>>().map(fromJson).toList();
}
