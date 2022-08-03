import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delivery_app_multi/controllers/user_controller.dart';
import 'package:delivery_app_multi/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../constant/constant.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UserController _userController = UserController();
  bool obscureText = true;

  void showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro!'),
            titleTextStyle: const TextStyle(color: Colors.red, fontSize: 20),
            content: Text(errorMessage),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: _userController.processing.isFalse
              ? AppBar(
                  foregroundColor: Colors.blue[900],
                  backgroundColor: Colors.white,
                  elevation: 0,
                )
              : null,
          body: _userController.processing.isTrue
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
                  minimum: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: Image.asset(
                                      'assets/logo-multidrogas-mini.png')
                                  .image,
                              fit: BoxFit.fitWidth,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          height: 30,
                          child: DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 21, color: Colors.blue[900]),
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                pause: const Duration(milliseconds: 500),
                                animatedTexts: [
                                  TyperAnimatedText(
                                      'Com você, pela saúde da nossa gente',
                                      speed: const Duration(milliseconds: 100),
                                      textAlign: TextAlign.center)
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text('Seja Bem-Vindo(a)',
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  autofocus: false,
                                  readOnly: _userController.processing.value,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Insira seu email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('Email'),
                                    labelStyle: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  autofocus: false,
                                  readOnly: _userController.processing.value,
                                  controller: passwordController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Insira sua senha';
                                    }
                                    return null;
                                  },
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    label: const Text('Senha'),
                                    labelStyle: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                      icon: obscureText == true
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF0D47A1)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Esqueceu sua senha?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900]),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: _userController.processing.isFalse
                                          ? () {}
                                          : null,
                                      child: Text(
                                        'Clique aqui',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900],
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _userController.processing.isFalse
                                    ? () async {
                                        if (formKey.currentState!.validate()) {
                                          _userController.changeStatus();
                                          int resp =
                                              await _userController.login(
                                                  emailController.text.trim(),
                                                  passwordController.text
                                                      .trim());

                                          switch (resp) {
                                            case 200:
                                              Navigator.of(context).pop();
                                              break;
                                            case 101:
                                              _userController.changeStatus();
                                              showError(
                                                  'Usuário e/ou senha inválidos');
                                              break;
                                            default:
                                              _userController.changeStatus();
                                              showError(
                                                  'Ocorreu um erro ao processar sua solicitação.');
                                              break;
                                          }
                                        }
                                      }
                                    : null,
                                child: const Text('Entrar',
                                    style: TextStyle(fontSize: 22)),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Ainda não possui uma conta?',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[900]),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: _userController.processing.isFalse
                                  ? () {
                                      Navigator.of(context)
                                          .pushNamed('/signup/userdata');
                                    }
                                  : null,
                              child: Text(
                                'Criar agora',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
