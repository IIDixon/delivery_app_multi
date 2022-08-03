import 'dart:convert';
import 'package:get/get.dart';
import 'package:delivery_app_multi/constant/constant.dart';
import 'package:delivery_app_multi/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final obsController = TextEditingController();
  final UserController _userController = Get.put(UserController());

  var search = true;

  var cepFormatter = MaskTextInputFormatter(mask: '#####-###');

  final keyFormAddress = GlobalKey<FormState>();

  @override
  void initState() {
    streetController.text = profile['address']['street'];
    numberController.text = profile['address']['number'];
    districtController.text = profile['address']['district'];
    cityController.text = profile['address']['city'];
    cepController.text = profile['address']['CEP'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Endereço'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: keyFormAddress,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          onFieldSubmitted: (cep) async {
                            if (cepController.text.isNotEmpty) {
                              Map address = await _userController
                                  .getAddress(cep.replaceAll('-', ''));
                              setAddress(address);
                            }
                          },
                          controller: cepController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          inputFormatters: [cepFormatter],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: const Text('CEP'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF424242)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: const Text('Número'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF424242)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF424242)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: obsController,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            label: const Text('Complemento'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (keyFormAddress.currentState!.validate()) {
                      profile['address']['street'] = streetController.text;
                      profile['address']['number'] = numberController.text;
                      profile['address']['district'] = districtController.text;
                      profile['address']['city'] = cityController.text;
                      profile['address']['CEP'] = cepController.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          content: Text('Endereço alterado'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                ))
              ]),
            ],
          ),
        ),
      ),
    );
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
        streetController.text = address['logradouro'];
        districtController.text = address['bairro'];
        cityController.text = address['localidade'];
      });
    }
  }
}
