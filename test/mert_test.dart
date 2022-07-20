import 'package:flutter_test/flutter_test.dart';

import 'package:mert/mert.dart';

void main() {
  test('Get my github url', () async {
    final mert = Mert();
    expect(await mert.getGithubProfileUrl('imertgul'), 'https://github.com/imertgul');
  });
}
