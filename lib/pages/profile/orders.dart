import 'package:delivery_app_multi/constant/constant.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
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
          future: getOrders(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary),
                    strokeWidth: 5,
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
                        children: const [
                          Icon(Icons.error),
                          Text('Erro ao carregar os pedidos'),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: ListTile(
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF0D47A1),
                              ),
                              title: Text(
                                  'Pedido - ${orders[index]['numeroVenda']}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue[900])),
                              subtitle: Text('Data - ${orders[index]['data']}',
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
                      });
                }
            }
          },
        ),
      ),
    );
  }

  Future<List<Map>> getOrders() async {
    return orders;
  }
}
