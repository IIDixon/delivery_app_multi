import 'package:delivery_app_multi/pages/cart_page.dart';
import 'package:delivery_app_multi/pages/homepage.dart';
import 'package:delivery_app_multi/pages/profile_page.dart';
import 'package:delivery_app_multi/widgets/list_lojas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../models/cart.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int activeTab = 0;
  Cart cart = Get.put(Cart());
  AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: activeTab == 0 ? getDrawer(context) : null,
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(),
      backgroundColor: Colors.white,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getDrawer(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: SingleChildScrollView(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image(
                        image: Image.asset('assets/logo-multidrogas-mini.png')
                            .image,
                        fit: BoxFit.scaleDown,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue[900]),
            ),
            Card(
              elevation: 3,
              child: ListTile(
                onTap: () {},
                title: const Text(
                  'Alterar loja',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
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
            color: Colors.red,
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
