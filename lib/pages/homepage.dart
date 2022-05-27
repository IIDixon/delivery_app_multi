import 'package:delivery_app_multi/models/item.dart';
import 'package:delivery_app_multi/pages/item_page.dart';
import 'package:delivery_app_multi/pages/root_page.dart';
import 'package:delivery_app_multi/widgets/custom_sliders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';
import '../route/route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(seconds: 1);
    controller.reverseDuration = const Duration(seconds: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('Vantagens exclusivas da Rede Multidrogas',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ),
          const Divider(
            color: Colors.black,
          ),
          CustomeCarouselHomePage(items: slider),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Mais Vendidos',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.arrow_back_ios, color: Colors.red, size: 17),
                    Icon(Icons.arrow_forward_ios, color: Colors.red, size: 17),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(items.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      Navigator.of(context).push(routePageItem(items[index]));
                    },
                    child: Container(
                      height: 250,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                //height: 220,
                                //width: 150,
                                child: Image(
                                  image:
                                      Image.asset('assets/download.jpg').image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  items[index]['description'],
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Text(
                              "De: ${items[index]['pmc']}",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text("Por: ${items[index]['venda']}",
                                style: TextStyle(
                                    color: Colors.blue[800], fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'UP Vitam Vitaminas',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.arrow_back_ios, color: Colors.red, size: 17),
                    Icon(Icons.arrow_forward_ios, color: Colors.red, size: 17),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(upvitam.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      Navigator.of(context).push(routePageItem(upvitam[index]));
                    },
                    child: Container(
                      height: 250,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                //height: 220,
                                //width: 150,
                                child: Image(
                                  image: NetworkImage(upvitam[index]['imgUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  upvitam[index]['description'],
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Text(
                              "De: ${upvitam[index]['pmc']}",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text("Por: ${upvitam[index]['venda']}",
                                style: TextStyle(
                                    color: Colors.blue[800], fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Categorias',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.arrow_back_ios, color: Colors.red, size: 17),
                    Icon(Icons.arrow_forward_ios, color: Colors.red, size: 17),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            categories[index]['title'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ))
                      /*Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(categories[index]['imgUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            categories[index]['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),*/
                      ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  /*Route createRoute(Map<String, dynamic> item) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ItemPage(
        item: item,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 1500),
    );
  }*/

  Future<dynamic> showModal(BuildContext context, Map<String, dynamic> item) {
    int qtde = 1;

    void decrement() {
      setState(() {
        qtde = -1;
      });
    }

    void increment() {
      setState(() {
        qtde += 1;
      });
    }

    return showModalBottomSheet(
        elevation: 5,
        transitionAnimationController: controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            //color: Colors.grey.withOpacity(0.2),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image: NetworkImage(item['imgUrl']),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item['description'],
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Laboratório: ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(item['laboratorio'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Quantidade: ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(item['qtde'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Categoria: ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(item['categoria'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'De: ',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            item['pmc'],
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Por: ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            item['venda'],
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 35),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.blue),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        qtde > 1
                                                            ? decrement()
                                                            : Null;
                                                        print(qtde);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          size: 20,
                                                          color: Colors.red),
                                                    ),
                                                    Text('$qtde',
                                                        style: const TextStyle(
                                                            fontSize: 20)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        increment();
                                                        print(qtde);
                                                      },
                                                      child: const Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                /*Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.blue),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(Icons.remove,
                                                  size: 18, color: Colors.red),
                                              Text('$qtde',
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                              const Icon(Icons.add,
                                                  size: 18, color: Colors.blue),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Voltar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      'Item Adicionado ao carrinho',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Comprar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
