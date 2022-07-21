import 'package:delivery_app_multi/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/person.dart';

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
  final UserController _userController = UserController();
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
                      '/root', ModalRoute.withName('/'));
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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: _userController.processing.isFalse
            ? Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                        heroTag: "btn3",
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.navigate_before),
                        onPressed: _userController.processing.isFalse
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : null),
                    FloatingActionButton(
                        heroTag: "btn4",
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.navigate_next),
                        onPressed: _userController.processing.isFalse
                            ? () async {
                                if (verificaCampos() &&
                                    emailKey.currentState!.validate()) {
                                  person.email.value = emailController.text;
                                  person.password.value =
                                      passwordController.text;
                                  _userController.changeStatus();
                                  int resp = await _userController
                                      .userRegistration(person);

                                  if (resp == 200) {
                                    showSuccess();
                                  } else if (resp == 101) {
                                    showError('Email já possui cadastro.');
                                  } else {
                                    showError(
                                        'Houve um erro ao processar sua solicitação.');
                                  }
                                }
                              }
                            : null)
                  ],
                ),
              )
            : null,
        body: SafeArea(
          child: _userController.processing.isTrue
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
                            'Insira suas credenciais para acesso',
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
                                  readOnly: _userController.processing.value,
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
                                  readOnly: _userController.processing.value,
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
                                  readOnly: _userController.processing.value,
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
