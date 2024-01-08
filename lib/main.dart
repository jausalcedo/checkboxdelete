import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingListApp());
}

List<String> itemsToDelete = [];
bool status = false;

class ShoppingListApp extends StatefulWidget {
  const ShoppingListApp({super.key});

  @override
  State<ShoppingListApp> createState() => _ShoppingListAppState();
}

class _ShoppingListAppState extends State<ShoppingListApp> {
  final TextEditingController input = TextEditingController();

  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.check_circle_outline),
          title: const Text("Shopping List"),
          actions: [
            IconButton(
              onPressed: (){
                for (var element in itemsToDelete) {
                  items.remove(element);
                }
                itemsToDelete = [];
                setState(() {
                  items;
                });
              },
              icon: const Icon(Icons.cleaning_services_rounded)
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: input,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Item"
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              items.add(input.text);
                            });
                            input.clear();
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) => Items(items[index], status),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

// ignore: must_be_immutable
class Items extends StatefulWidget {
  Items(this.item, this.status, {super.key});

  bool status;
  final String item;

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.item,
              style: TextStyle(
                decoration: widget.status ? TextDecoration.lineThrough : TextDecoration.none,
                decorationThickness: 3
              ),
            ),
            Checkbox(
              value: widget.status,
              onChanged: (bool? value) {
                setState(() {
                  widget.status = value!;
                  widget.status ? itemsToDelete.add(widget.item) : itemsToDelete.remove(widget.item); 
                });
              }
            )
          ],
        ),
      ),
    );
  }
}