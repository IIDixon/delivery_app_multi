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
                            onPressed: () {
                              showModal(context, orders[index]);
                            },
                            child: ListTile(
                              leading: Hero(
                                  tag: 'order',
                                  child: Icon(
                                    Icons.sell_rounded,
                                    color: Colors.blue[900],
                                  )),
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
                    item['data'],
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
                      Text('R\$ ${item['total']}',
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
                        item['status'],
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
                      itemBuilder: (context, index){
                        return Container(
                          child: ListTile(
                            leading: Text('${item['itens'][index]['qtde']}x',
                              style: const TextStyle(fontSize: 17, color: Colors.red),),
                            title: Text(item['itens'][index]['descricao'],
                              //overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(fontSize: 19, color: Colors.blue[900]),),
                            trailing: Text('R\$ ${item['itens'][index]['total']}',
                              style: const TextStyle(fontSize: 19, color: Colors.blue),),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Voltar', style: TextStyle(color: Colors.blue[900], fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0XFF0D47A1)),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
