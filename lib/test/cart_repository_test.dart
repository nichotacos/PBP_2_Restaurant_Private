import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_2_restaurant/repository/cart_repository.dart';
import 'package:pbp_2_restaurant/model/cart_model.dart';

void main() {
  test('Create Cart Item Success', () async {
    final result = await CartRepository.cartTesting(
        name: 'Burger',
        quantity: '3',
        desc: 'The Best Burger in The World',
        price: '10',
        id_user: '1',
        image: 'assets/images/burger/beef-burger.png');
    expect(result, isA<CartModel>());
  });
  
  test('deleteCartItem success', () async {
    final result = await CartRepository.deleteTesting(
      id: '17',
    );

    expect(result, "Berhasil Menghapus Data");
  });
}
