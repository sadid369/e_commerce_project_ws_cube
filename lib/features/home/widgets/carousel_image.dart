import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_project_ws_cube/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);
  void navigateToDetailScreen(
      {required BuildContext context, required Product product}) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: context
          .read<ProductDetailsServices>()
          .fetchAllProduct(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return CarouselSlider(
            items: snapshot.data!.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => InkWell(
                    onTap: () {
                      navigateToDetailScreen(context: context, product: i);
                    },
                    child: Container(
                      height: 350,
                      child: Image.network(
                        i.images[0],
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 350,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 200,
            ),
          );
        }
        return Container();
      },
    );
  }
}
