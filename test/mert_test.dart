import 'package:test/test.dart';
import 'package:mert/mert.dart';

void main() {
  test('Get my github url', () async {
    final mert = ExampleGithubHelper();
    expect(await mert.getGithubProfileUrl('imertgul'),
        'https://github.com/imertgul');
  });
}
