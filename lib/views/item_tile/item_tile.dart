import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/cart.dart';
import '../../models/item.dart';
import '../../route/route.dart';

class ItemTile extends StatelessWidget {
  ItemTile({Key? key, required this.item}) : super(key: key);
  late Item item;
  Cart cart = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey[200],
      shadowColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Imagem
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(routePageItem(item));
              },
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: item.imgUrl,
                  fit: BoxFit.fill),
            ),
          ),

          // Nome
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(routePageItem(item));
                },
                child: Text(
                  item.name,
                  softWrap: true,
                  //overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          // Preço
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(routePageItem(item));
              },
              child: Text(
                'R\$ ${NumberFormat('###.00', 'pt_BR').format(item.valueSale)}',
                style: TextStyle(color: Colors.blue[800], fontSize: 20),
              ),
            ),
          ),

          // Botão 'Adicionar'
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      item.qtde = 1;
                      cart.items.add(item);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 1000),
                        content: Text(
                          'Produto adicionado ao carrinho',
                          style: TextStyle(fontSize: 18),
                        ),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(Icons.add_shopping_cart),
                        Text(
                          'Comprar',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
