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

  void addItem(Item item) {
    var contain = items.where((e) => e.id == item.id);
    if (contain.isNotEmpty) {
      int idx = items.indexWhere((element) => element.id == item.id);
      items[idx].qtde = items[idx].qtde! + item.qtde!;
    } else {
      items.add(item);
    }
  }

  void removeItem(int i) {
    items.removeAt(i);
  }

  void reset() {
    items.clear();
  }

  double valueItems() {
    double value = 0;

    items.forEach((element) {
      value += element.valueSale * element.qtde!;
    });
    return value;
  }
}
