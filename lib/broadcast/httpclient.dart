import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;

  HttpClient(this.userAgent, this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _inner.send(request);
  }
}