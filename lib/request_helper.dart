import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: constant_identifier_names
enum RequestType { GET, PUT, DELETE, POST, PATCH }

abstract class MertBase {
  final String base;
  const MertBase({this.base = 'localhost'});

  Future<http.Response> request(
    RequestType type,
    String path, {
    Object? data = '',
    Map<String, dynamic>? queryParameters,
    String contentType = 'application/json',
    String accept = 'text/plain',
    String? token,
    String tokenPrefix = 'Bearer',
  }) async {
    final url = Uri.http(base, path, queryParameters);

    final headers = <String, String>{};
    if (token != null) {
      headers['Authorization'] = '$tokenPrefix $token';
    }
    if (type == RequestType.PUT ||
        type == RequestType.POST ||
        type == RequestType.PATCH) {
      headers['Content-Type'] = contentType;
      headers['accept'] = accept;
    }
    dynamic json;
    (data is! String) ? json = jsonEncode(data) : json = data;

    late http.Response resp;
    try {
      switch (type) {
        case RequestType.GET:
          resp = await http.get(url, headers: headers);
          break;
        case RequestType.PATCH:
          resp = await http.patch(url, body: json, headers: headers);
          break;
        case RequestType.POST:
          resp = await http.post(url, body: json, headers: headers);
          break;
        case RequestType.PUT:
          resp = await http.put(url, body: json, headers: headers);
          break;
        case RequestType.DELETE:
          resp = await http.delete(url, headers: headers);
          break;
      }
      return resp;
    } catch (e, s) {
      throw Exception(e.toString() + s.toString());
    }
  }

  Future<void> multiPartRequest(
    RequestType type,
    String path, 
    String filePath, {
    Map<String, String>? data,
    Map<String, dynamic>? queryParameters,
    String contentType = 'application/json',
    String accept = 'text/plain',
    String? token,
    String tokenPrefix = 'Bearer',
  }) async {
    final url = Uri.http(base, path, queryParameters);
    var request = http.MultipartRequest(type.toString().split('.').last, url)
      ..fields.addAll(data!)
      ..files.add(await http.MultipartFile.fromPath(
          'package', filePath,
          contentType: MediaType('application', 'x-tar')));
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');
  }
}
