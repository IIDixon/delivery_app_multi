import 'package:delivery_app_multi/controllers/order_controller.dart';
import 'package:delivery_app_multi/views/orders_details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/person.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  Person person = Get.put(Person());

  final ScrollController scrollController = ScrollController();
  final OrderController _orderController = OrderController();

  List<String> status = [
    'Confirmando',
    'Separando',
    'Em rota de entrega',
    'Entregue',
    'Cancelado'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: _orderController.getOrders(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary),
                      strokeWidth: 5,
                    ),
                  ),
                );
              case ConnectionState.none:
                return Center(
                  child: Text('Nenhum pedido encontrado',
                      style: TextStyle(fontSize: 22, color: Colors.blue[900])),
                );
              default:
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Icon(Icons.error),
                          Text(
                              'Erro ao carregar os pedidos - ${snapshot.error}'),
                        ],
                      ),
                    ),
                  );
                } else {
                  return createData(context, snapshot);
                }
            }
          },
        ),
      ),
    );
  }

  Widget createData(BuildContext context, AsyncSnapshot snapshot) {
    List<Map> order = snapshot.data;
    return order.isNotEmpty
        ? Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            child: ListView.builder(
                controller: scrollController,
                itemCount: order.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Carregando produtos...',
                            style: TextStyle(fontSize: 16),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 20),
                        ));
                        List<Map> itens = await _orderController
                            .getItens(order[index]['sale']);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => OrderDetails(
                                sale: order[index], itens: itens)));
                        //showModal(context, order[index], itens);
                      },
                      child: ListTile(
                        leading: Hero(
                            tag: 'order $index',
                            child: Icon(
                              Icons.sell_rounded,
                              color: Colors.blue[900],
                            )),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF0D47A1),
                        ),
                        title: Text('Loja - ${order[index]['loja']}',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue[900])),
                        subtitle: Text(
                            'Data - ${DateFormat('dd/MM/yyyy H:mm').format(DateTime.parse(order[index]['date']['iso']))}',
                            style: TextStyle(
                                fontSize: 18, color: Colors.blue[900])),
                      ),
                      style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(seconds: 2),
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shadowColor: Colors.blue[900],
                        onSurface: Colors.blue[900],
                      ),
                    ),
                  );
                }))
        : Center(
            child: Text(
              "Nenhum pedido encontrado",
              style: TextStyle(fontSize: 20, color: Colors.blue[900]),
            ),
          );
  }
}
