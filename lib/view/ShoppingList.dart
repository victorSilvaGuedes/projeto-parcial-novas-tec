import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gerenciar listas de compras'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ShoppingListScreen(shoppingLists: GlobalData.shoppingLists),
      ),
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  final List<ShoppingList> shoppingLists;

  ShoppingListScreen({required this.shoppingLists});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: widget.shoppingLists.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.shoppingLists[index].name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingListDetailScreen(
                            shoppingList: widget.shoppingLists[index],
                            onUpdate: () {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editShoppingListName(widget.shoppingLists[index], index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _removeShoppingList(index);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Nome da lista de compras',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                  ),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    _createNewShoppingList(_textEditingController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Criar nova lista de compra'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  void _createNewShoppingList(String listName) {
    setState(() {
      widget.shoppingLists.add(ShoppingList(name: listName, items: []));
    });
    _textEditingController.clear();
  }

  void _removeShoppingList(int index) {
    setState(() {
      widget.shoppingLists.removeAt(index);
    });
  }

  void _editShoppingListName(ShoppingList shoppingList, int index) {
    TextEditingController _listNameController = TextEditingController(text: shoppingList.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar nome da lista'),
          content: TextField(
  controller: _listNameController,
  decoration: InputDecoration(
    labelText: 'Novo nome da lista',
    labelStyle: TextStyle(fontSize: 20),
  ),
  style: TextStyle(fontSize: 20),
),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  shoppingList.name = _listNameController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 42),
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
              ),
              child: Text('Salvar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
              ),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

class ShoppingListDetailScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  final Function onUpdate;

  const ShoppingListDetailScreen({
    required this.shoppingList,
    required this.onUpdate,
  });

  @override
  _ShoppingListDetailScreenState createState() => _ShoppingListDetailScreenState();
}

class _ShoppingListDetailScreenState extends State<ShoppingListDetailScreen> {
  final TextEditingController _itemTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  late List<ShoppingListItem> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.shoppingList.items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.shoppingList.items.where((item) => item.name.toLowerCase().contains(searchText)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onUpdate();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                    labelText: 'Pesquisar por nome do item',
                prefixIcon: Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                    ),
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 20,
                                decoration: item.bought ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        'Quantidade: ${item.quantity}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          item.bought
                            ? SizedBox()
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editItem(item.name, item.quantity, index);
                                },
                              ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeItem(index);
                            },
                          ),
                          Checkbox(
                            value: item.bought,
                            onChanged: (value) {
                              _toggleItemBought(index);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _itemTextController,
                  decoration: InputDecoration(
                    labelText: 'Nome do item',
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _quantityTextController,
                  decoration: InputDecoration(
                    labelText: 'Quantidade do Item',
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _addItem(_itemTextController.text, _quantityTextController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    textStyle: const TextStyle(fontSize: 20),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Adicionar Item'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _addItem(String itemName, String quantity) {
    if (itemName.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        widget.shoppingList.items.add(ShoppingListItem(name: itemName, quantity: quantity));
      });
      _itemTextController.clear();
      _quantityTextController.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      widget.shoppingList.items.removeAt(index);
    });
  }

  void _editItem(String itemName, String quantity, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: TextEditingController(text: itemName),
                onChanged: (value) {
                  itemName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Nome do Item',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController(text: quantity),
                onChanged: (value) {
                  quantity = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Quantidade do Item',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.shoppingList.items[index] = ShoppingListItem(name: itemName, quantity: quantity);
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 42),
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
              ),
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _toggleItemBought(int index) {
    setState(() {
      widget.shoppingList.items[index].bought = !widget.shoppingList.items[index].bought;
    });
  }
}

class GlobalData {
  static List<ShoppingList> shoppingLists = [];
}

class ShoppingList {
  late String name;
  List<ShoppingListItem> items;

  ShoppingList({required this.name, required this.items});
}

class ShoppingListItem {
  late String name;
  late String quantity;
  bool bought;

  ShoppingListItem({required this.name, required this.quantity, this.bought = false});
}
