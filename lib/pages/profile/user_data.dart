import 'package:delivery_app_multi/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/person.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {

  Person person = Person();

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final celController = TextEditingController();
  final emailController = TextEditingController();

  var cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');

  var celFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
  );

  @override
  void initState() {
    setState(() {
      nameController.text = person.name.value;
      cpfController.text = cpfFormatter.maskText(person.cpf.value);
      celController.text = celFormatter.maskText(person.tel.value);
      emailController.text = person.email.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Meus Dados'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: InputDecoration(
                          label: const Text('Nome Completo'),
                          labelStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 22),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF0D47A1))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        inputFormatters: [cpfFormatter],
                        keyboardType: TextInputType.number,
                        controller: cpfController,
                        decoration: InputDecoration(
                          label: const Text('CPF (Opcional)'),
                          labelStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 22),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF0D47A1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF0D47A1))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 22,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF0D47A1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF0D47A1))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        inputFormatters: [celFormatter],
                        keyboardType: TextInputType.number,
                        controller: celController,
                        decoration: InputDecoration(
                          label: const Text('Telefone'),
                          labelStyle: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 22,
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF0D47A1)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF0D47A1))),
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
                  onPressed: () {
                    final person = Person.fromjson(
                        name: nameController.text,
                        cpf: cpfController.text,
                        email: emailController.text,
                        tel: celController.text);

                    setState(() {
                      profile['name'] = nameController.text;
                      profile['CPF'] = cpfController.text;
                      profile['email'] = emailController.text;
                      profile['cel'] = celController.text;
                    });

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Dados alterados com sucesso'),
                      backgroundColor: Colors.red,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
