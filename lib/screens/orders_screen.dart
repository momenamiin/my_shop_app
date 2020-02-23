import 'package:flutter/material.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as OI;

class OrderScreen extends StatelessWidget {
  static const routeName = './orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OI.OrderItem(orderData.orders[i])),
    );
  }
}
