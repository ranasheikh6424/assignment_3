import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../customTextField.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = "/add-new-product";

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _adNewProductInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new product"),
        backgroundColor: Colors.green,
        toolbarHeight: 80,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: _buildProductForm(),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'Name',
                  labelText: 'Product name',
                  controller: _nameTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'Price',
                  labelText: 'Product Price',
                  controller: _priceTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Price";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'Quantity',
                  labelText: 'Product Quantity',
                  controller: _quantityTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product quantity";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'Total',
                  labelText: 'Total price',
                  controller: _totalTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product Total price";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: '',
                  labelText: 'Product code',
                  controller: _codeTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product code";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'image',
                  labelText: 'Product image url',
                  controller: _imageTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Product image url";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: _adNewProductInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                      child: Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                if (_globalKey.currentState!.validate()) {
                                  _addNewProduct();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Add your product"))),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _addNewProduct() async {
    _adNewProductInProgress = false;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
    };
    Response resonse = await post(uri,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(requestBody));
    _adNewProductInProgress = false;
    setState(() {});
    if (resonse.statusCode == 200) {
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("New Product Added Successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("New Product Added failed! try again")));
    }
  }

  void _clearTextField() {
    _nameTEController.clear();
    _priceTEController.clear();
    _codeTEController.clear();
    _quantityTEController.clear();
    _totalTEController.clear();
    _imageTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _priceTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    _totalTEController.dispose();
    _imageTEController.dispose();
  }
}
