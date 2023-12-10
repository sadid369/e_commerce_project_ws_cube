import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/features/cart/screens/cart_screen.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/widgets/product_card.dart';
import 'package:e_commerce_project_ws_cube/features/search/screens/search_screen.dart';
import 'package:e_commerce_project_ws_cube/models/product.dart';
import 'package:e_commerce_project_ws_cube/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  static const String routeName = "/all-products";
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // void navigateToDetailScreen() {

  // }

  @override
  Widget build(BuildContext context) {
    // final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Product',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Badge(
                      backgroundColor: GlobalVariables.secondaryColor,
                      label:
                          Consumer<UserProvider>(builder: (context, data, _) {
                        return Text(data.user.cart.length.toString());
                      }),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder<List<Product>>(
          future: context
              .watch<ProductDetailsServices>()
              .fetchAllProduct(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProductDetailScreen.routeName,
                        arguments: product,
                      );
                    },
                    child: ProductCard(
                      imageUrl: product.images[0],
                      name: product.name,
                      price: product.price,
                      onBuy: () {
                        context
                            .read<ProductDetailsServices>()
                            .addToCart(context: context, product: product);
                      },
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ));
  }
}
