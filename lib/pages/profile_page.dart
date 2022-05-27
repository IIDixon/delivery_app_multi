import 'package:flutter/material.dart';

import '../constant/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Olá ${profile['name']}',
                  style: TextStyle(fontSize: 25, color: Colors.blue[900]),
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
                  onPressed: () {},
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
                      shadowColor: Colors.blue[900]),
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
                    onPressed: () {},
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
