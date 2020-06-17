import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/provider/auth.dart';
import 'package:my_shop/provider/orders.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'provider/products_provider.dart';
import 'provider/cart.dart';
import 'screens/cart_screen.dart';
import "screens/user_products_Screen.dart";
import 'screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (ctx, auth, previousproducts) => ProductsProvider(
              auth.token,
              auth.userId,
              previousproducts == null ? [] : previousproducts.list),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetalisScreeen.id: (context) => ProductDetalisScreeen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            EditProductScreen.routename: (context) => EditProductScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
          },
        ),
      ),
    );
  }
}
