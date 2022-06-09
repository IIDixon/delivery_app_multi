import 'dart:convert';

import 'package:delivery_app_multi/models/person.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> login() async{
    http.Response response;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();


    Map<String, String> header = {
      "X-Parse-Application-Id" : "7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9",
      "X-Parse-REST-API-Key" : "SG65TqMUHhXx9CduNNumoQkkfzDCXOuu9DQNdPiq",
      "Content-Type" : "application/json"
    };

    Map<String, String> body = {
      "email" : email,
      "password" : password
    };

    response = await http.post(Uri.parse("https://parseapi.back4app.com/parse/functions/login"), headers: header, body: jsonEncode(body));

    var resp = json.decode(response.body);
    if(response.statusCode == 200){
      var cpf;
      var tel;
      if(resp['result']['cpf'] != null){
        cpf = resp['result']['cpf'];
      }
      if(resp['result']['tel'] != null){
        tel = resp['result']['tel'];
      }

      Person person = Person.fromjson(name: resp['result']['name'], cpf: cpf, email: resp['result']['email'], tel: tel);
      //person.name.value = resp['result']['name'];
      //person.email.value = resp['result']['email'];
      Navigator.of(context).pop();
      //Navigator.of(context).pop;
    }else if(resp['code'] == 101){
      showError('Usuário e/ou senha inválidos');
    }
    else{
      showError(resp['error']);
    }
  }

  void showError(String errorMessage){
    showDialog(
        context: context,
        builder: (BuildContext context){
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
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.blue[900],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
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
                    image:
                        Image.asset('assets/logo-multidrogas-mini.png').image,
                    fit: BoxFit.fitWidth,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Seja Bem-Vindo(a)',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 23,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Insira sua senha';
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: const Text('Senha'),
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      child: Row(
                        children: [
                          Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                                fontSize: 18, color: Colors.blue[900]),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {},
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child:
                          const Text('Entrar', style: TextStyle(fontSize: 22)),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[900]),
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
                    style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup/userdata');
                    },
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
    );
  }
}
