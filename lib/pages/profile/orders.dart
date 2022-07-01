import 'dart:convert';

import 'package:delivery_app_multi/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../back4app/credentials.dart';
import '../../models/person.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

enum Status { confirmando, separando, rota, entregue }

class _MyOrdersPageState extends State<MyOrdersPage> {
  Person person = Get.put(Person());

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
                          Icon(Icons.error),
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
    return ListView.builder(
        itemCount: order.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showModal(context, order[index]);
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
                title: Text(
                    'Pedido - 11111' /*'Pedido - ${orders[index]['numeroVenda']}'*/,
                    style: TextStyle(fontSize: 20, color: Colors.blue[900])),
                subtitle: Text(
                    'Data - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(order[index]['date']['iso']))}',
                    style: TextStyle(fontSize: 18, color: Colors.blue[900])),
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

  Future<List<Map>> getOrders() async {
    Map<String, String> header = {
      "X-Parse-Application-Id": keyApplicationId,
      "X-Parse-REST-API-Key": restApiKey,
      "Content-Type": "application/json"
    };

    Map body = {'userid': person.id.value};

    http.Response response = await http.post(
        Uri.parse(
            "https://parseapi.back4app.com/parse/functions/get-salesUser"),
        headers: header,
        body: jsonEncode(body));

    var resp = json.decode(response.body);
    Map orders = jsonDecode(response.body);
    List<Map> list = [];

    for (int i = 0; i < orders['result'].length; i++) {
      list.add(orders['result'][i]);
    }
    print('Resultado - $list - ${list.length}');
    return list;
  }

  Future<dynamic> showModal(BuildContext context, Map item) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pedido ${item['numeroVenda']}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    item['date'],
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Estabelecimento: ',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            item['loja'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue[900]),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Valor Total: ',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      Text('R\$ ${item['value']}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 20))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Forma de Pagamento: ',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['tpp'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${Status.values[(item['status'])]}',
                        style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.blue[900]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Itens',
                    style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                  )
                ]),
                Divider(color: Colors.blue[900]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: item['itens'].length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              leading: Text(
                                '${item['itens'][index]['qtde']}x',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.red),
                              ),
                              title: Text(
                                item['itens'][index]['product'],
                                //overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 19, color: Colors.blue[900]),
                              ),
                              trailing: Text(
                                'R\$ ${item['itens'][index]['totalValue']}',
                                style: const TextStyle(
                                    fontSize: 19, color: Colors.blue),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*Navigator.of(context)
                            .popUntil(ModalRoute.withName('/profile'));*/
                      },
                      child: Text(
                        'Voltar',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0XFF0D47A1)),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
