typedef JsonMapper<T> = T Function(Map<String, dynamic> json);

abstract final class JsonListMapper {
  const JsonListMapper._();

  /// Converts a JSON list to a list of objects of type T using the provided fromJson function.
  ///
  /// If the jsonList is null, an empty list is returned.
  static List<T> fromJsonList<T>(final dynamic jsonList, final JsonMapper<T> fromJson) =>
      jsonList == null ? [] : (jsonList as List<dynamic>).cast<Map<String, dynamic>>().map(fromJson).toList();
}
