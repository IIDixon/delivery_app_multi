import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Produtos',
                  style: TextStyle(color: Colors.blue[900], fontSize: 22))
            ],
          ),
          Divider(color: Colors.blue[900]),
          Expanded(
            child: Obx(
              () => cart.items.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListView(
                        children: List.generate(cart.items.length, (index) {
                          return Slidable(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image(
                                      image: NetworkImage(
                                          cart.items[index].imgUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cart.items[index].name,
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontSize: 18)),
                                        Row(children: [
                                          Text(
                                              '${cart.items[index].qtde} Unidade(s)',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 18))
                                        ]),
                                        Row(
                                          children: [
                                            const Text(
                                              'Valor Unitário:',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'R\$ ${cart.items[index].valueSale.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Valor Total:',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'R\$ ${(cart.items[index].qtde * cart.items[index].valueSale).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Deslize para remover o item',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              backgroundColor: Colors.red,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                            ));
                                          },
                                          icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.red),
                                          tooltip: 'Deslize para remover',
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                            endActionPane: ActionPane(
                              extentRatio: 0.25,
                              motion: BehindMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) => {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration:
                                              Duration(milliseconds: 1500),
                                          content: Text(
                                              'Item removido do carrinho',
                                              style: TextStyle(fontSize: 16)),
                                          backgroundColor: Colors.red),
                                    ),
                                    cart.removeItem(index)
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Remover',
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  : const Center(
                      child: Text('Nenhum item no carrinho',
                          style: TextStyle(color: Colors.blue, fontSize: 26))),
            ),
          ),
          Container(
            height: 160,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Totais',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Sub total:',
                            style: TextStyle(color: Colors.blue, fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(() => Text(
                            'R\$ ${cart.valueItems().toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 18))),
                        //Text('R\$ 200.00')
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Frete:',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18)),
                          const SizedBox(width: 10),
                          Text('R\$ 5.00',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Valor Total:',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              'R\$ ${(cart.valueItems() + 5).toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Obx(
                          () => ElevatedButton(
                            onPressed: cart.items.isNotEmpty ? () {} : null,
                            child: const Text('Ir para Pagamento',
                                style: TextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
