import 'package:flutter/material.dart';
import 'package:my_shop/provider/orders.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'provider/products_provider.dart';
import 'provider/cart.dart';
import 'screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetalisScreeen.id: (context) => ProductDetalisScreeen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
        },
      ),
    );
  }
}
