import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoggingHttpClient extends http.BaseClient {
  final http.Client _inner;

  LoggingHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('Request: ${request.method} ${request.url}');
    print('Headers: ${request.headers}');
    if (request is http.Request) {
      print('Body: ${request.body}');
    }

    final response = await _inner.send(request);

    // Use ByteStream to handle the response stream
    final byteStream = http.ByteStream(response.stream);

    // Capture the response body
    final responseBody = await byteStream.bytesToString();
    print('Response: $responseBody');

    // Re-create a new StreamedResponse with the captured body
    final newResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(responseBody)]),
      response.statusCode,
      contentLength: response.contentLength,
      request: response.request,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
      isRedirect: response.isRedirect,
    );

    return newResponse;
  }
}
