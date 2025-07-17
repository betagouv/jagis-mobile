class DeepLink {
  String? _route;

  void uri(final Uri value) {
    _route = Uri(path: value.path, query: value.query).toString();
  }

  bool get hasDeepLink => _route != null;

  String consumeRoute() {
    final value = _route;
    _route = null;

    return value ?? '';
  }
}
