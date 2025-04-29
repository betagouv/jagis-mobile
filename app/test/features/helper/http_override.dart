import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';

typedef ImageResolver = List<int> Function(Uri uri);

class HttpOverridesMock extends HttpOverrides {
  @override
  HttpClient createHttpClient(final SecurityContext? context) => _createHttpClient();
}

class _MockHttpClient extends Mock implements HttpClient {
  _MockHttpClient() {
    registerFallbackValue((List<int> _) {});
    registerFallbackValue(Uri());
    registerFallbackValue(const Stream<List<int>>.empty());
  }
}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {}

class _MockHttpHeaders extends Mock implements HttpHeaders {}

HttpClient _createHttpClient() {
  final client = _MockHttpClient();
  final imageResolver = _defaultImageResolver();
  when(
    () => client.getUrl(any()),
  ).thenAnswer((final invokation) async => _createRequest(invokation.positionalArguments.first as Uri, imageResolver));
  when(
    () => client.openUrl(any(), any()),
  ).thenAnswer((final invokation) async => _createRequest(invokation.positionalArguments.last as Uri, imageResolver));

  return client;
}

HttpClientRequest _createRequest(final Uri uri, final ImageResolver imageResolver) {
  final request = _MockHttpClientRequest();
  final headers = _MockHttpHeaders();

  when(() => request.headers).thenReturn(headers);
  when(() => request.addStream(any())).thenAnswer((final invocation) {
    final stream = invocation.positionalArguments.first as Stream<List<int>>;

    // ignore: avoid-collection-mutating-methods, prefer-bytes-builder
    return stream.fold<List<int>>(<int>[], (final previous, final element) => previous..addAll(element));
  });
  when(request.close).thenAnswer((_) async => _createResponse(uri, imageResolver));

  return request;
}

HttpClientResponse _createResponse(final Uri uri, final ImageResolver imageResolver) {
  final response = _MockHttpClientResponse();
  final headers = _MockHttpHeaders();
  final data = imageResolver(uri);

  when(() => response.headers).thenReturn(headers);
  when(() => response.contentLength).thenReturn(data.length);
  when(() => response.statusCode).thenReturn(HttpStatus.ok);
  when(() => response.isRedirect).thenReturn(false);
  when(() => response.redirects).thenReturn([]);
  when(() => response.persistentConnection).thenReturn(false);
  when(() => response.reasonPhrase).thenReturn('OK');
  when(() => response.compressionState).thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(() => response.handleError(any(), test: any(named: 'test'))).thenAnswer((_) => Stream<List<int>>.value(data));
  when(
    () => response.listen(
      any(),
      onError: any(named: 'onError'),
      onDone: any(named: 'onDone'),
      cancelOnError: any(named: 'cancelOnError'),
    ),
  ).thenAnswer((final invocation) {
    final onData = invocation.positionalArguments.first as void Function(List<int>);
    final onDone = invocation.namedArguments[#onDone] as void Function()?;

    return Stream<List<int>>.value(data).listen(onData, onDone: onDone);
  });

  return response;
}

ImageResolver _defaultImageResolver() => (final uri) {
  final extension = uri.path.split('.').last;

  return _mockedResponses[extension] ?? _transparentPixelPng;
};

final _mockedResponses = {'png': _transparentPixelPng, 'svg': _emptySvg};

final _emptySvg = '<svg viewBox="0 0 10 10" />'.codeUnits;
final _transparentPixelPng = base64Decode(
  '''iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==''',
);
