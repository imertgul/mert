library mert;

import 'package:mert/decoder_extensions.dart';
import 'package:mert/request_helper.dart';

//This is example implementation of MertRequestHelper
class Mert extends MertBase {
  Mert() : super(base: 'api.github.com');

  Future<String> getGithubProfileUrl(String username) async {
    final resp = await request(RequestType.GET, '/users/$username');
    final decoded = resp.decodeMap();
    return decoded['html_url'];
  }
}
