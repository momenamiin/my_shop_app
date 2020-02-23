import 'package:flutter/material.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/provider/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool ShowFavorite;
  ProductsGrid(this.ShowFavorite);
  @override
  Widget build(BuildContext context) {
    final ProductsData = Provider.of<ProductsProvider>(context);
    final loadedproducts =
        ShowFavorite ? ProductsData.FavoriteList : ProductsData.list;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedproducts.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: loadedproducts[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
