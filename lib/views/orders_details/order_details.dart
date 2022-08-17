import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final Map sale;
  final List<Map> itens;

  const OrderDetails({required this.sale, required this.itens, Key? key})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<String> status = [
    'Confirmando',
    'Separando',
    'Em rota de entrega',
    'Entregue',
    'Cancelado'
  ];

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Detalhes do Pedido'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Pedido - ${widget.sale['sale'].toString().toUpperCase()}',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              )
            ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              DateFormat('dd/MM/yyyy H:mm')
                  .format(DateTime.parse(widget.sale['date']['iso'])),
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
                      widget.sale['loja'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, color: Colors.blue[900]),
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
                Text(
                    'R\$ ${NumberFormat('###.00', 'pt_BR').format(widget.sale['value'])} ',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.blue[900], fontSize: 20)),
                const Text(
                  '(Incluso frete)',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
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
                  'Forma de Pagamento: ',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.sale['tpp'],
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
                  status[widget.sale['status']],
                  style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                )
              ],
            ),
          ),
          Divider(color: Colors.blue[900]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Itens',
              style: TextStyle(fontSize: 19, color: Colors.blue[900]),
            )
          ]),
          Divider(color: Colors.blue[900]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                interactive: true,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.itens.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          leading: Text(
                            '${widget.itens[index]['unit']}x',
                            style: const TextStyle(
                                fontSize: 17, color: Colors.red),
                          ),
                          title: Text(
                            widget.itens[index]['name'],
                            //overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 19, color: Colors.blue[900]),
                          ),
                          trailing: Text(
                            'R\$ ${NumberFormat('###.00', 'pt_BR').format(widget.itens[index]['totalValue'])}',
                            style: const TextStyle(
                                fontSize: 19, color: Colors.blue),
                          ),
                        ),
                      );
                    }),
              ),
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
        ]),
      ),
    );
  }
}
