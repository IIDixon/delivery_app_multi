import 'package:delivery_app_multi/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/item.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, required this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int qtde = 1;
  late Item item;
  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Produto'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 220,
                      child: Image(
                        image: NetworkImage(widget.item['imgUrl']),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['description'],
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text('Laboratório:',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 20)),
                          const SizedBox(width: 10),
                          Text(widget.item['laboratorio'],
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 20))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text('Categoria:',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 20)),
                          const SizedBox(width: 10),
                          Text(widget.item['categoria'],
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.blue)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                const Text('De: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red)),
                                Text(
                                  NumberFormat('###.00', 'pt_BR')
                                      .format(widget.item['pmc']),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Por: ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF0D47A1))),
                                Text(
                                    NumberFormat('###.00', 'pt_BR')
                                        .format(widget.item['venda']),
                                    style: const TextStyle(
                                        color: Color(0xFF0D47A1), fontSize: 20))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: const Color(0xFF0D47A1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (qtde > 1) {
                                          setState(() {
                                            qtde -= 1;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove,
                                          size: 20, color: Colors.red),
                                    ),
                                    Text('$qtde',
                                        style: const TextStyle(fontSize: 20)),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          qtde += 1;
                                        });
                                      },
                                      child: const Icon(Icons.add,
                                          size: 20, color: Color(0xFF0D47A1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              item =
                                  Item.fromJson(json: widget.item, qtde: qtde);
                              cart.items.add(item);
                              //print(cart.valueItems());
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 1000),
                                content: Text('Item adicionado ao carrinho',
                                    style: TextStyle(fontSize: 18)),
                              ));
                            },
                            child: Text('Comprar',
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 22)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900],
                              onPrimary: Colors.blue,
                              shadowColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
