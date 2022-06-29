import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/cart.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int checkoutTpp = 1;
  Cart cart = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Revisão',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Endereço de entrega',
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 20),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rua: ',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                                Text(
                                  profile['address']['street'],
                                  style: TextStyle(
                                      color: Colors.blue[900], fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nº: ',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 18),
                                  ),
                                  Text(
                                    profile['address']['number'],
                                    style: TextStyle(
                                        color: Colors.blue[900], fontSize: 18),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bairro: ',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 18),
                                  ),
                                  Text(
                                    profile['address']['district'],
                                    style: TextStyle(
                                        color: Colors.blue[900], fontSize: 18),
                                  )
                                ]),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Cidade: ',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                                Text(
                                  profile['address']['city'],
                                  style: TextStyle(
                                      color: Colors.blue[900], fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'CEP: ',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                                Text(
                                  profile['address']['CEP'],
                                  style: TextStyle(
                                      color: Colors.blue[900], fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Forma de pagamento',
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'PIX (Pagamento online)',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              onTap: () {
                                setState(() {
                                  checkoutTpp = 1;
                                });
                              },
                              leading: Radio(
                                  value: 1,
                                  groupValue: checkoutTpp,
                                  onChanged: (int? value) {
                                    setState(() {
                                      checkoutTpp = value!;
                                    });
                                  },
                                  autofocus: true,
                                  activeColor: Colors.blue[900],
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => const Color(0xFF0D47A1))),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Dinheiro (Pagamento na entrega)',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              onTap: () {
                                setState(() {
                                  checkoutTpp = 2;
                                });
                              },
                              leading: Radio(
                                  value: 2,
                                  groupValue: checkoutTpp,
                                  onChanged: (int? value) {
                                    setState(() {
                                      checkoutTpp = value!;
                                    });
                                  },
                                  activeColor: Colors.blue[900],
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => const Color(0xFF0D47A1))),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Cartão de crédito (Pagamento na entrega)',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              onTap: () {
                                setState(() {
                                  checkoutTpp = 3;
                                });
                              },
                              leading: Radio(
                                  value: 3,
                                  groupValue: checkoutTpp,
                                  onChanged: (int? value) {
                                    setState(() {
                                      checkoutTpp = value!;
                                    });
                                  },
                                  activeColor: Colors.blue[900],
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => const Color(0xFF0D47A1))),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Cartão de débito (Pagamento na entrega)',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              onTap: () {
                                setState(() {
                                  checkoutTpp = 4;
                                });
                              },
                              leading: Radio(
                                value: 4,
                                groupValue: checkoutTpp,
                                onChanged: (int? value) {
                                  setState(() {
                                    checkoutTpp = value!;
                                  });
                                },
                                activeColor: Colors.blue[900],
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => const Color(0xFF0D47A1)),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFF0D47A1)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tempo médio para entrega',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ),
                              Text(
                                '50 Minutos',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.blue[900]),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Valor Total',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    primary: Colors.blue[900]),
                                onPressed: () {},
                                child: const Text(
                                  'Finalizar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
