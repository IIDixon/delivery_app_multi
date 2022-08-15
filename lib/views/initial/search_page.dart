import 'package:delivery_app_multi/constant/constant.dart';
import 'package:delivery_app_multi/controllers/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/item.dart';
import '../item_tile/item_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.baseItems}) : super(key: key);

  final List<Map<String, dynamic>>? baseItems;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ItemController _itemController = ItemController();
  String texto = '';
  //List items = <Map>[].obs;

  @override
  void initState() {
    super.initState();

    if (widget.baseItems != null) {
      _itemController.addList(widget.baseItems!);
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _searchController,
                      onSubmitted: (text) {
                        _itemController.searchItemsBD(text);
                        texto = 'Nenhum produto encontrado';
                      },
                      style: const TextStyle(fontSize: 20),
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
                              _itemController
                                  .searchItemsBD(_searchController.text);
                              texto = 'Nenhum produto encontrado';
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
            Expanded(
              child: Obx(
                () => searchItems.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 7.5 / 11.5,
                        ),
                        itemCount: searchItems.length,
                        itemBuilder: (_, index) {
                          return ItemTile(
                              item: Item.fromJson(json: searchItems[index]));
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            texto,
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 20),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
