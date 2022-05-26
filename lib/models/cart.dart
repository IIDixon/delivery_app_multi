import 'package:delivery_app_multi/models/item.dart';
import 'package:get/get.dart';

class Cart extends GetxController {
  static final Cart cart = Cart._internal();

  factory Cart() {
    return cart;
  }

  Cart._internal();

  //List<Map<String, dynamic>> items = [];

  // Observador do Getx, para carregar o carrinho sempre
  //que for incluído algum item
  var items = <Item>[].obs;

  double valueItems() {
    double value = 0;
    for (int i = 0; i <= items.length; i++) {
      value += items[i].valueSale;
    }
    return value;
  }
}
