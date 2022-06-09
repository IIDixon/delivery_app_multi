import 'package:delivery_app_multi/pages/login/SignUp_Pages/address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../models/person.dart';

class SignupUserData extends StatefulWidget {
  const SignupUserData({Key? key}) : super(key: key);

  @override
  _SignupUserDataState createState() => _SignupUserDataState();
}

class _SignupUserDataState extends State<SignupUserData> {
  Person person = Person();
  final userDataKey = GlobalKey<FormState>();
  final form1 = GlobalKey<FormState>();
  final form2 = GlobalKey<FormState>();
  var cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');

  final cpfController = TextEditingController();
  final nameController = TextEditingController();

  bool verificaCampos() {
    if (userDataKey.currentState!.validate()) {
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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Cadastro',
        ),
        centerTitle: true,
        foregroundColor: Colors.blue[900],
        backgroundColor: Colors.white,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(40),
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          child: const Icon(Icons.navigate_next),
          onPressed: () {
            if (verificaCampos() && userDataKey.currentState!.validate()) {
              person.name.value = nameController.text;
              Navigator.of(context).pushNamed('/signup/addressdata');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      'Aqui você deverá inserir seus dados pessoais',
                      style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      softWrap: true,
                    ))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: userDataKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Preencha seu nome';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: const Text('Nome e sobrenome'),
                          labelStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 20),
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
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: cpfController,
                        validator: (text) {
                          if (text!.length < 14 &&
                              cpfController.text.isNotEmpty) {
                            return 'CPF Inválido';
                          }
                          return null;
                        },
                        inputFormatters: [cpfFormatter],
                        decoration: InputDecoration(
                          label: const Text('CPF (Opcional)'),
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
                value: 0.33,
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
