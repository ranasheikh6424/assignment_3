import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../modals/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.onDelete,
    required this.product,
  });

  final Product product;
  final Function(String) onDelete;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName ?? 'Unknown Product',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text("Price: ${widget.product.unitPrice ?? 'N/A'}"),
                  Text("Quantity: ${widget.product.quantity ?? 'N/A'}"),
                  Text("Total price: ${widget.product.totalPrice ?? 'N/A'}"),
                  Text("Product code: ${widget.product.productCode ?? 'N/A'}"),
                  Text("Added on: ${widget.product.createdDate ?? 'N/A'}"),
                  const SizedBox(height: 10),
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      //border: Border.all(color: Colors.amber, width: 2),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product.image?.isNotEmpty == true
                              ? widget.product.image!
                              : 'https://via.placeholder.com/300',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    widget.onDelete(widget.product.id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Delete Product',
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UpdateProductScreen.name,
                      arguments: widget.product,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  tooltip: 'Edit Product',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
