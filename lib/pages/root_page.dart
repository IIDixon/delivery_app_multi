import 'package:delivery_app_multi/pages/cart_page.dart';
import 'package:delivery_app_multi/pages/homepage.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/cart.dart';
import '../models/person.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int activeTab = 0;
  Cart cart = Cart();
  AppBar? appBar;

  @override
  void initState() {
    Person person = Person();
    person.name.value = profile['name'];
    person.cpf.value = profile['CPF'];
    person.email.value = profile['email'];
    person.tel.value = profile['cel'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.white,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    switch (activeTab) {
      case 0:
        return AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0.8,
          title: Image(
            image: Image.asset('assets/logo-multidrogas-mini.png').image,
            fit: BoxFit.fitWidth,
            color: Colors.white,
          ),
          centerTitle: true,
        );
        break;
      case 1:
        return AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0.8,
          title: const Text(
            'Busca',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        );
        break;
      case 2:
        return AppBar(
          actions: [
            Obx(
              () => IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  size: 28,
                ),
                tooltip: 'Esvaziar carrinho',
                onPressed: cart.items.isNotEmpty
                    ? () {
                        cart.items.clear();
                      }
                    : null,
              ),
            )
          ],
          backgroundColor: Colors.blue[900],
          elevation: 0.8,
          title: const Text(
            'Carrinho',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        );
        break;
      case 3:
        return AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0.8,
          title: const Text(
            'Perfil',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        );
        break;
      default:
        return AppBar();
    }
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: const [
        HomePage(),
        Center(
          child: Text(
            'Página 2',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CartPage(),
        ProfilePage(),
      ],
    );
  }

  Widget getFooter() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: activeTab == index
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.transparent,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      activeTab = index;
                    });
                  },
                  icon: Icon(icons[index]),
                  color: activeTab == index ? Colors.white : Colors.black,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
