import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_2_restaurant/repository/register_repository.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';

void main() {
  test('register success', () async {
    final hasil = await RegisterRepository.registerTesting(
      username: 'nicho2',
      password: "nicho555",
      email: 'nicho2@gmail.com',
      telephone: '99129382983',
      bornDate: '2023-12-01',
      poin: 0,
      imageData: 'noImage',
      address: '',
    );
    print(hasil?.data);
  });

  test('register failed', () async {
    final result = await RegisterRepository.registerTesting(
      username: '',
      password: "",
      email: '',
      telephone: '',
      bornDate: '',
      poin: 0,
      imageData: '',
      address: '',
    );
    print(result?.data);
    expect(result, null);
  });
}
