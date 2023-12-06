import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_2_restaurant/repository/login_repository.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';

void main() {
  test('login success', () async {
    final hasil = await LoginRepository.loginTesting(
        username: 'nicho', password: "nicho123");
    expect(hasil?.data.username, equals('nicho'));
    expect(hasil?.data.password, equals('nicho123'));
  });

  test('login failed', () async {
    final result = await LoginRepository.loginTesting(
        username: 'invalid', password: 'invalid');
    expect(result, null);
  });
}
