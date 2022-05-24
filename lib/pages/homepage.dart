import 'package:delivery_app_multi/widgets/custom_sliders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            padding: const EdgeInsets.only(top: 8, left: 8),
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            child: Image.asset('assets/download.jpg'),
                          ),
                          Text(
                            items[index]['description'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                          Text("De: ${items[index]['pmc']}",
                              style: const TextStyle(color: Colors.red)),
                          Text("Por: ${items[index]['venda']}",
                              style: TextStyle(
                                  color: Colors.blue[800], fontSize: 18)),
                        ],
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
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
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
                  child: Container(
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
                          SizedBox(
                            height: 250,
                            //width: 150,
                            child: Image(
                              image: upvitam[index]['imgUrl'].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              upvitam[index]['description'],
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Text(
                            "De: ${upvitam[index]['pmc']}",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Por: ${upvitam[index]['venda']}",
                              style: TextStyle(
                                  color: Colors.blue[800], fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
