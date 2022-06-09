import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
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

  bool processing = false;

  final userDataKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> refreshKey =
  GlobalKey<RefreshIndicatorState>();

  bool verificaCampos(){
    if(userDataKey.currentState != null){
      return true;
    }
    return false;
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

  void userUpdate() async {
    final email = person.email.value;
    final name = person.name.value;
    final id = person.id.value;
    final cpf = person.cpf.value;
    final tel = person.tel.value;

    person.reset();

    http.Response response;
    Map<String, String> header = {
      "X-Parse-Application-Id": "7CL23wlKcmRh61hQN1OXNfKpY8YGFXOeQAOBhSH9",
      "X-Parse-REST-API-Key": "SG65TqMUHhXx9CduNNumoQkkfzDCXOuu9DQNdPiq",
      "Content-Type": "application/json"
    };

    Map<String, String> body = {
      "email": email,
      "id": id,
      "name": name!,
      "cpf": cpf,
      "tel": tel
    };

    response = await http.post(
        Uri.parse("https://parseapi.back4app.com/parse/functions/update-user"),
        headers: header,
        body: jsonEncode(body));
    //await Future.delayed(const Duration(seconds: 2));
    var resp = json.decode(response.body);
    if (response.statusCode == 200) {
      person.name.value = resp['result']['name'];
      person.email.value = resp['result']['email'];
      person.cpf.value = resp['result']['cpf'];
      person.tel.value = resp['result']['telefone'];
      person.id.value = resp['result']['objectId'];

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Dados alterados com sucesso'),
        backgroundColor: Colors.red,
      ));
      Navigator.pop(context);
    } else {
      showError(resp['error']);
      setState(() {
        processing = false;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      nameController.text = person.name.value!;
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
      body: RefreshIndicator(
        edgeOffset: 200,
        key: refreshKey,
        color: Colors.blue[900],
        backgroundColor: Colors.white,
        strokeWidth: 3,
        onRefresh: ()async{
          return userUpdate();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: userDataKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            readOnly: processing,
                            validator: (text){
                              if(text == null || text.isEmpty){
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
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
                            readOnly: processing,
                            validator: (text){
                              if(cpfController.text.length > 1 && cpfController.text.length < 11){
                                return 'CPF inválido';
                              }
                              return null;
                            },
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
                            readOnly: processing,
                            validator: (text){
                              if (text == null || text.isEmpty) {
                                return 'Campo obrigatório';
                              } else if (GetUtils.isEmail(emailController.text) ==
                                  false) {
                                return 'Email inválido';
                              }
                              return null;
                            },
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
                            readOnly: processing,
                            validator: (text){
                              if(celController.text.length > 1 && celController.text.length < 11){
                                return 'Telefone inválido';
                              }
                              return null;
                            },
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
              ),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: processing == false ? (){
                      if(verificaCampos() && userDataKey.currentState!.validate()){
                        final person = Person.fromjson(
                            name: nameController.text,
                            cpf: cpfController.text,
                            email: emailController.text,
                            tel: celController.text);
                        setState(() {
                          processing = true;
                        });
                        refreshKey.currentState?.show();
                      }
                    } : null,
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
      ),
    );
  }
}
