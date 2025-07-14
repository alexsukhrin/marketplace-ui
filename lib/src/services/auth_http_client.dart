import 'package:http/http.dart' as http;
import 'auth_storage.dart';
import 'auth_service.dart';

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final accessToken = await AuthStorage.getAccessToken();

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    http.StreamedResponse response = await _inner.send(request);

    if (response.statusCode == 401) {
      final refreshed = await AuthService.refreshAccessToken();
      if (refreshed) {
        final newAccessToken = await AuthStorage.getAccessToken();
        if (newAccessToken != null) {
          request.headers['Authorization'] = 'Bearer $newAccessToken';
          response = await _inner.send(request);
        }
      }
    }

    return response;
  }
}
