import 'package:delivery_app_multi/pages/profile/address.dart';
import 'package:delivery_app_multi/pages/profile/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/person.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Person person = Person();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF0D47A1)),
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const UserDataPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration:
                              const Duration(milliseconds: 1200),
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
                      style: TextStyle(color: Colors.blue[900], fontSize: 22),
                    ),
                    subtitle: const Text('Dados pessoais',
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AddressPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0, 1);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 1200),
                          ));
                    },
                    child: ListTile(
                      leading: Icon(Icons.maps_home_work_outlined,
                          size: 50, color: Colors.blue[900]),
                      title: Text('Endereço',
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 22)),
                      subtitle: const Text('Meu endereço',
                          style: TextStyle(color: Colors.blue, fontSize: 18)),
                    ),
                    style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(seconds: 2),
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
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag_outlined,
                        size: 50, color: Colors.blue[900]),
                    title: Text('Meus Pedidos',
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 22)),
                    subtitle: const Text('Pedidos Efetuados',
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ),
                  style: ElevatedButton.styleFrom(
                      animationDuration: const Duration(seconds: 2),
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                      shadowColor: Colors.blue[900]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
