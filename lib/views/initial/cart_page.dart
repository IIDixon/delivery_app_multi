import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart.dart';
import '../../models/person.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart cart = Get.put(Cart());
  Person person = Get.put(Person());

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => IconButton(
              icon: const Icon(
                Icons.delete_forever,
                size: 28,
              ),
              tooltip: 'Esvaziar carrinho',
              onPressed: cart.items.isNotEmpty
                  ? () {
                      cart.items.clear();
                    }
                  : null,
            ),
          )
        ],
        backgroundColor: Colors.blue[900],
        elevation: 0.8,
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                        child: Scrollbar(
                          controller: scrollController,
                          trackVisibility: true,
                          thumbVisibility: true,
                          interactive: true,
                          child: ListView(
                            controller: scrollController,
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
                                                  'R\$ ${NumberFormat('###.00', 'pt_BR').format(cart.items[index].valueSale)}',
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
                                                  'R\$ ${NumberFormat('###.00', 'pt_BR').format(cart.items[index].qtde! * cart.items[index].valueSale)}',
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
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      'Deslize para remover o item',
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(
                                                      milliseconds: 1000),
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
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      onPressed: (context) => {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars(),
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              content: Text(
                                                  'Item removido do carrinho',
                                                  style:
                                                      TextStyle(fontSize: 16)),
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
                        ),
                      )
                    : const Center(
                        child: Text('Nenhum item no carrinho',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 26))),
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
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() => Text(
                              cart.items.isNotEmpty
                                  ? 'R\$ ${NumberFormat('###.00', 'pt_BR').format(cart.valueItems())}'
                                  : '-',
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
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18)),
                            const SizedBox(width: 10),
                            Text(
                                'R\$ ${NumberFormat('###.00', 'pt_BR').format(5)}',
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
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18)),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                'R\$ ${NumberFormat('###.00', 'pt_BR').format(cart.valueItems() + 5)}',
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
                              onPressed: cart.items.isNotEmpty
                                  ? () {
                                      if (person.name.value == '' ||
                                          person.name.value!.isEmpty) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Aviso'),
                                                titleTextStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20),
                                                content: const Text(
                                                    'Para prosseguir será necessário realizar login.'),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushNamed('/signin');
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        Navigator.of(context)
                                            .pushNamed('/checkout');
                                      }
                                    }
                                  : null,
                              child: const Text(
                                'Ir para Pagamento',
                                style: TextStyle(fontSize: 18),
                              ),
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
      ),
    );
  }
}
