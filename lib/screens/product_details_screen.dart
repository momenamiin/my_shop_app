import 'package:flutter/material.dart';
import 'package:my_shop/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/provider/products_provider.dart';

class ProductDetalisScreeen extends StatelessWidget {
  static const id = 'productdetails';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final loadedproduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedproduct.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$ ${loadedproduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              loadedproduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
