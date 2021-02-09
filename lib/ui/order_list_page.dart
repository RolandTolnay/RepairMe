import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairme/model/order.dart';
import 'package:repairme/service/order_provider.dart';

import '../service/order_builder.dart';
import '../service/services.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Consumer<OrderProvider>(
        builder: (_, provider, __) {
          return ListView(
            children: provider.orders
                .map((order) => _OrderItem(order: order))
                .toList(),
          );
        },
      ),
      floatingActionButton: _AddOrderButton(),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final total = order.amount * order.component.price;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Row(
          children: [
            Text('${order.amount}x',
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${order.component.name}'),
                Text(
                  '${order.component.price}฿ each',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ],
        ),
        trailing: Text('Total: $total'),
      ),
    );
  }
}

class _AddOrderButton extends StatelessWidget {
  const _AddOrderButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final order = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Provider(
            create: (_) => service<OrderBuilder>(),
            child: NewOrderDialog(),
          ),
        );
        context.read<OrderProvider>().addOrder(order);
      },
    );
  }
}

class NewOrderDialog extends StatelessWidget {
  const NewOrderDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final builder = context.read<OrderBuilder>();

    return AlertDialog(
      title: Text('New Order'),
      content: Form(
        key: builder.newOrderFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: builder.componentNameController,
              validator: builder.validateComponentName,
              decoration: InputDecoration(labelText: 'Component Name'),
            ),
            TextFormField(
              controller: builder.componentPriceController,
              validator: builder.validateComponentPrice,
              decoration: InputDecoration(labelText: 'Component Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: builder.amountController,
              validator: builder.validateAmount,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('CANCEL')),
        FlatButton(
            onPressed: () {
              final order = builder.makeOrder();
              if (order != null) {
                Navigator.pop(context, order);
              }
            },
            child: Text('ADD'))
      ],
    );
  }
}
