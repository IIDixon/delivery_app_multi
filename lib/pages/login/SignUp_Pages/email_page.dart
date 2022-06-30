import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../back4app/credentials.dart';
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

  var processing = false.obs;

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
    final cpf = person.cpf.value;
    final tel = person.tel.value;

    person.reset();

    http.Response response;
    Map<String, String> header = {
      "X-Parse-Application-Id": keyApplicationId,
      "X-Parse-REST-API-Key": restApiKey,
      "Content-Type": "application/json"
    };

    Map<String, String> body = {
      "email": email,
      "password": password,
      "name": name!,
      "cpf": cpf,
      "tel": tel
    };

    response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/create-user"),
        headers: header,
        body: jsonEncode(body));
    //await Future.delayed(const Duration(seconds: 2));
    var resp = json.decode(response.body);
    if (response.statusCode == 200) {
      person = Person.fromjson(
          name: resp['result']['name'],
          cpf: cpf,
          email: resp['result']['email'],
          tel: tel,
          id: resp['result']['objectId']);

      processing.value = false;
      showSuccess();
    } else {
      processing.value = false;
      showError(resp['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: processing.value == false
            ? Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                        heroTag: "btn3",
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.navigate_before),
                        onPressed: processing.value == false
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : null),
                    FloatingActionButton(
                        heroTag: "btn4",
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.navigate_next),
                        onPressed: processing.value == false
                            ? () {
                                if (verificaCampos() &&
                                    emailKey.currentState!.validate()) {
                                  person.email.value = emailController.text;
                                  person.password.value =
                                      passwordController.text;
                                  processing.value = true;
                                  userRegistration();
                                  //userRegistration();
                                }
                              }
                            : null)
                  ],
                ),
              )
            : null,
        body: SafeArea(
          child: processing.value == true
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF0D47A1)),
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Validando dados...',
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 22),
                        ),
                      )
                    ],
                  ),
                )
              : SafeArea(
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
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 20),
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
                                  readOnly: processing.value,
                                  controller: emailController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Campo obrigatório';
                                    } else if (GetUtils.isEmail(
                                            emailController.text) ==
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
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  readOnly: processing.value,
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
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  readOnly: processing.value,
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
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
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
      ),
    );
  }
}
