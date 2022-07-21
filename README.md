## Mert
This package helps you about request, decode response and creating sdk.

```dart
library mert;

import 'package:mert/decoder_extensions.dart';
import 'package:mert/request_helper.dart';

//This is example implementation of MertBase
class Mert extends MertBase {
  Mert() : super(base: 'api.github.com');

  Future<String> getGithubProfileUrl(String username) async {
    final resp = await request(RequestType.GET, '/users/$username');
    final decoded = resp.decodeMap();
    return decoded['html_url'];
  }
}

```

Create your own class and functions