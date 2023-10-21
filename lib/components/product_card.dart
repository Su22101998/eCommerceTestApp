import 'package:flutter/material.dart';
import '../models/get_product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.images.isNotEmpty ? product.images[0] : '', // Use the first image URL
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display product title
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.w800
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Display product price
                Text(
                  product.description,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:FontWeight.w400
                  ),
                ),
                const SizedBox(height: 5),
                // Display product price
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:FontWeight.w800
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}