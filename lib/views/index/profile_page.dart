import 'package:delivery_app_multi/views/profile/address.dart';
import 'package:delivery_app_multi/views/profile/orders.dart';
import 'package:delivery_app_multi/views/profile/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/person.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Person person = Person();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.8,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() => SingleChildScrollView(
              child: person.name.value == ''
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          /*Center(
                      child: Text("Usuário não logado",
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 22))),*/
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/signin');
                                  },
                                  child: const Text('Fazer login',
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ),
                            ],
                          )
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xFF0D47A1)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.person, size: 50)),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Obx(
                                  () => Text(
                                    'Olá ${person.name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.blue[900],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const UserDataPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(0, 1);
                                          const end = Offset.zero;
                                          const curve = Curves.ease;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 1000),
                                      ));
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person_outline_outlined,
                                    size: 50,
                                    color: Colors.blue[900],
                                  ),
                                  title: Text(
                                    'Meus dados',
                                    style: TextStyle(
                                        color: Colors.blue[900], fontSize: 22),
                                  ),
                                  subtitle: const Text('Dados pessoais',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  animationDuration: const Duration(seconds: 2),
                                  primary: Colors.white,
                                  onPrimary: Colors.blue,
                                  shadowColor: Colors.blue[900],
                                  onSurface: Colors.blue[900],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const AddressPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(0, 1);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                          transitionDuration: const Duration(
                                              milliseconds: 1000),
                                        ));
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.maps_home_work_outlined,
                                        size: 50, color: Colors.blue[900]),
                                    title: Text('Endereço',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 22)),
                                    subtitle: const Text('Meu endereço',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      animationDuration:
                                          const Duration(seconds: 2),
                                      primary: Colors.white,
                                      onPrimary: Colors.blue,
                                      shadowColor: Colors.blue[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const MyOrdersPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(0, 1);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                          transitionDuration: const Duration(
                                              milliseconds: 1000),
                                        ));
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.shopping_bag_outlined,
                                        size: 50, color: Colors.blue[900]),
                                    title: Text('Meus Pedidos',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 22)),
                                    subtitle: const Text('Pedidos Efetuados',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      animationDuration:
                                          const Duration(seconds: 2),
                                      primary: Colors.white,
                                      onPrimary: Colors.blue,
                                      shadowColor: Colors.blue[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Sair da conta',
                                          ),
                                          titleTextStyle: const TextStyle(
                                              color: Colors.red, fontSize: 22),
                                          content: Text(
                                            'Deseja sair da conta?',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.blue[900]),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text(
                                                'Sim',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  person.reset();
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'Não',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.exit_to_app_rounded,
                                      size: 50, color: Colors.red),
                                  title: Text('Sair da conta',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 22)),
                                ),
                                style: ElevatedButton.styleFrom(
                                    animationDuration:
                                        const Duration(seconds: 2),
                                    primary: Colors.white,
                                    onPrimary: Colors.red[100],
                                    shadowColor: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            )),
      ),
    );
  }
}
