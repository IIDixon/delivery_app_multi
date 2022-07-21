import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Busca'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Nome do Produto',
                          hintStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 18),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: GestureDetector(
                              child: Icon(
                                Icons.search,
                                size: 32,
                                color: Colors.blue[900],
                              ),
                              onTap: () {
                                print('busca');
                              },
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0D47A1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0D47A1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.blue[900],
            )
          ],
        ),
      ),
    );
  }
}
