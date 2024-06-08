import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meals/01/data/categories.dart';
import 'package:meals/01/models/categories.dart';
import 'package:meals/01/models/grocery_item.dart';

import "package:http/http.dart" as http;

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() {
    return _NewItemScreen();
  }
}

class _NewItemScreen extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  var enteredName = "";
  var enteredQuantity = 1;
  var selectedCategory = categories[Categories.vegetables]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(enteredName);
      final url = Uri.https("flutter-prep-e6a68-default-rtdb.firebaseio.com",
          "shppping-list.json");
      final response = await http.post(url,
          headers: {
            "Content-Type": "Application/json",
          },
          body: json.encode(
            {
              "name": enteredName,
              "quantity": enteredQuantity,
              "category": selectedCategory.title
            },
          ));
      final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        GroceryItem(
          id: resData["name"],
          name: enteredName,
          quantity: enteredQuantity,
          category: selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Item")),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return "Must be between 1 and 50 chars";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredName = value!;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration:
                              const InputDecoration(label: Text("Quantity")),
                          keyboardType: TextInputType.number,
                          initialValue: enteredQuantity.toString(),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return "Must be a valid positive number";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              enteredQuantity = int.parse(value!);
                            }
                            return;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: selectedCategory,
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(category.value.title),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          child: const Text("Reset")),
                      ElevatedButton(
                        onPressed: _saveItem,
                        child: const Text("Add"),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
