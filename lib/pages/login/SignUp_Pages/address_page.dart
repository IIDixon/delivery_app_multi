import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class SignupAddressPage extends StatefulWidget {
  const SignupAddressPage({Key? key}) : super(key: key);

  @override
  _SignupAddressPageState createState() => _SignupAddressPageState();
}

class _SignupAddressPageState extends State<SignupAddressPage> {
  final addressKey = GlobalKey<FormState>();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final obsController = TextEditingController();

  var search = true;
  var cepFormatter = MaskTextInputFormatter(mask: '#####-###');

  Future<Map> getAddress(String cep) async {
    http.Response response;

    response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    return json.decode(response.body);
  }

  void clearControllers() {
    streetController.clear();
    districtController.clear();
    numberController.clear();
    obsController.clear();
  }

  void setAddress(Map address) {
    if (address['logradouro'] == null ||
        address['logradouro'].toString().isEmpty) {
      clearControllers();
      setState(() {
        cityController.text = address['localidade'];
        search = false;
      });
    } else {
      setState(() {
        print(address);
        search = true;
        streetController.text = address['logradouro'];
        districtController.text = address['bairro'];
        cityController.text = address['localidade'];
      });
    }
  }

  bool verificaCampos() {
    if (addressKey.currentState != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.blue[900],
                child: const Icon(Icons.navigate_before),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.blue[900],
                child: const Icon(Icons.navigate_next),
                onPressed: () {
                  if (verificaCampos() && addressKey.currentState!.validate()) {
                    Navigator.of(context).pushNamed('/signup/emaildata');
                  }
                })
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preencha seu endereço principal',
                      style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      softWrap: true,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: addressKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        inputFormatters: [cepFormatter],
                        controller: cepController,
                        onEditingComplete: () async {
                          if (cepController.text.isNotEmpty) {
                            Map address = await getAddress(
                                cepController.text.replaceAll('-', ''));
                            setAddress(address);
                          }
                        },
                        onFieldSubmitted: (cep) async {
                          if (cepController.text.isNotEmpty) {
                            Map address =
                                await getAddress(cep.replaceAll('-', ''));
                            setAddress(address);
                          }
                        },
                        validator: (text) {
                          if (cepController.text.length < 8 ||
                              cepController.text.isEmpty) {
                            return 'CEP inválido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text('CEP'),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.blue[900]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1))),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: search,
                        controller: streetController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Rua'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text('Número'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: search,
                        controller: districtController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Bairro'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: cityController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Cidade'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: obsController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          label: const Text('Complemento'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0XFF0D47A1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LinearProgressIndicator(
                value: 0.66,
                backgroundColor: Colors.grey,
                color: Colors.blue[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
