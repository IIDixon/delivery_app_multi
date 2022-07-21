import 'package:delivery_app_multi/views/initial/cart_page.dart';
import 'package:delivery_app_multi/views/initial/homepage.dart';
import 'package:delivery_app_multi/views/initial/profile_page.dart';
import 'package:delivery_app_multi/views/initial/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cart.dart';
import '../../models/loja.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int activeTab = 0;
  Cart cart = Get.put(Cart());
  Loja loja = Get.put(Loja());
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: activeTab == 0 ? getDrawer(context) : null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        bottomNavigationBar: getFooter(),
        body: getBody(),
        floatingActionButton: activeTab == 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'btnReset',
                      backgroundColor: Colors.blue[900],
                      child: const Icon(
                        Icons.rotate_left_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Alterar loja'),
                                titleTextStyle: TextStyle(
                                    color: Colors.blue[900], fontSize: 19),
                                content: const Text(
                                  'Deseja alterar a loja selecionada? Caso seja alterada a loja, seu carrinho será esvaziado.',
                                  style: TextStyle(fontSize: 17),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      loja.id.value = '';
                                      cart.reset();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Confirmar',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.blue[900]),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    )
                  ],
                ),
              )
            : null);
  }

  /*Widget getDrawer(BuildContext context) {
    return Drawer(
      elevation: 1,
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
                      image:
                          Image.asset('assets/logo-multidrogas-mini.png').image,
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
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }*/

  /*PreferredSizeWidget getAppBar() {
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
  }*/

  // Páginas
  Widget getBody() {
    return PageView(
      //physics: const NeverScrollableScrollPhysics(), // Caso queira bloquear a troca de tela por gestos
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          activeTab = index;
        });
      },
      children: const [
        HomePage(),
        SearchPage(),
        CartPage(),
        ProfilePage(),
      ],
    );
  }

  /*Widget getBody() {
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
  }*/

  //BottomNavigator
  Widget getFooter() {
    return BottomNavigationBar(
      iconSize: 34,
      selectedFontSize: 17,
      unselectedFontSize: 15,
      currentIndex: activeTab,
      onTap: (i) {
        setState(() {
          activeTab = i;
          pageController.jumpToPage(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Início',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Perfil'),
      ],
    );
  }

  /*Widget getFooter() {
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
  */
}
