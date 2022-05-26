import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart cart = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Obx(
              () => ListView(
                children: List.generate(cart.items.length, (index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            image: NetworkImage(cart.items[index]['imgUrl']),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(cart.items[index]['description'])
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          )
          /* child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Valor total:',
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 18)),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => Text('${cart.valueItems()}')),
                  ],
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
