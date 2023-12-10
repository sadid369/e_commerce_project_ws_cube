import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final VoidCallback onBuy;

  ProductCard(
      {required this.imageUrl,
      required this.name,
      required this.price,
      required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: GlobalVariables.secondaryColor,
                  onPressed: onBuy,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
