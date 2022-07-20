import 'dart:convert';
import 'package:http/http.dart' as http;

extension Decoder on http.Response {
  Map<String, dynamic> decodeMap() {
    final resp = this;
    var respBody = resp.body;
    if (resp.statusCode >= 400 && resp.statusCode < 500) {
      throw Exception(resp.reasonPhrase ?? resp.statusCode.toString());
    }
    if (resp.statusCode >= 500 && resp.statusCode < 600) {
      throw Exception(resp.reasonPhrase ?? resp.statusCode.toString());
    }
    try {
      respBody = utf8.decode(resp.bodyBytes);
      // print(respBody);
    } catch (_) {
      // No-OP
    }
    if (respBody.isEmpty) {
      throw Exception('Empty body');
    }
    var jsonString = String.fromCharCodes(respBody.runes);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  List<dynamic> decodeList() {
    final resp = this;
    var respBody = resp.body;
    if (resp.statusCode >= 400 && resp.statusCode < 500) {
      throw Exception(resp.reasonPhrase ?? resp.statusCode.toString());
    }
    if (resp.statusCode >= 500 && resp.statusCode < 600) {
      throw Exception(resp.reasonPhrase ?? resp.statusCode.toString());
    }
    try {
      respBody = utf8.decode(resp.bodyBytes);
      // print(respBody);
    } catch (_) {
      // No-OP
    }
    if (respBody.isEmpty) {
      throw Exception('Empty body');
    }
    var jsonString = String.fromCharCodes(respBody.runes);
    return jsonDecode(jsonString) as List<dynamic>;
  }
}
