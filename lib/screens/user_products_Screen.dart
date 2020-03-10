import 'package:flutter/material.dart';
import 'package:my_shop/provider/products_provider.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "./user-products";
  @override
  Widget build(BuildContext context) {
    final prodctsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routename);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: prodctsData.list.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserProductItem(
                prodctsData.list[i].id,
                prodctsData.list[i].title,
                prodctsData.list[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
