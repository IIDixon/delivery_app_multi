import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/person.dart';
import '../../root_page.dart';

class SignupEmailPage extends StatefulWidget {
  const SignupEmailPage({Key? key}) : super(key: key);

  @override
  _SignupEmailPageState createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  Person person = Person();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();

  final emailKey = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool verificaCampos() {
    if (emailKey.currentState != null) {
      return true;
    }
    return false;
  }

  Future<dynamic> showSuccess() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cadastro realizado'),
            titleTextStyle: TextStyle(color: Colors.blue[900], fontSize: 20),
            content: const Text('Cadastro realizado com sucesso',
                style: TextStyle(color: Colors.blue, fontSize: 18)),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  //'puseAndRemoveUntil' em conjunto com '(Route<dynamic> route) => false'
                  // remove todas as telas da pilha antes de trazer uma nova tela
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/root', ModalRoute.withName('/root'));
                },
              ),
            ],
          );
        });
  }

  void showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro!'),
            titleTextStyle: const TextStyle(color: Colors.red, fontSize: 20),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void userRegistration() async {
    final email = person.email.value;
    final name = person.name.value;
    final password = person.password.value;

    http.Response response;
    Map<String, String> header = {
      "X-Parse-Application-Id": "7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9",
      "X-Parse-REST-API-Key": "SG65TqMUHhXx9CduNNumoQkkfzDCXOuu9DQNdPiq",
      "Content-Type": "application/json"
    };

    Map<String, String> body = {
      "username": email,
      "email": email,
      "password": password,
      "name": name
    };

    response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/create-user"),
        headers: header,
        body: jsonEncode(body));
    await Future.delayed(const Duration(seconds: 2));
    var resp = json.decode(response.body);
    if (response.statusCode == 200) {
      showSuccess();
    } else {
      showError(resp['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                  if (verificaCampos() && emailKey.currentState!.validate()) {
                    person.email.value = emailController.text;
                    person.password.value = passwordController.text;
                    refreshIndicatorKey.currentState?.show();
                    //userRegistration();
                  }
                })
          ],
        ),
      ),
      body: RefreshIndicator(
        edgeOffset: 200,
        key: refreshIndicatorKey,
        color: Colors.blue[900],
        backgroundColor: Colors.white,
        strokeWidth: 3,
        onRefresh: () async {
          //return Future<void>.delayed(const Duration(seconds: 3));
          return userRegistration();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Insira suas credencias para acesso',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                    softWrap: true,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Form(
                    key: emailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (GetUtils.isEmail(emailController.text) ==
                                false) {
                              return 'Email inválido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (passwordController.text !=
                                passwordConfController.text) {
                              return 'As senhas digitadas não coincidem';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Senha'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordConfController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (passwordController.text !=
                                passwordConfController.text) {
                              return 'As senhas digitadas não coincidem';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Confirmar Senha'),
                            labelStyle: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFF0D47A1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: 0.99,
                  backgroundColor: Colors.grey,
                  color: Colors.blue[900],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
