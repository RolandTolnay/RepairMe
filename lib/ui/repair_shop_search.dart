import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/repair_shop.dart';

class RepairShopSearch extends SearchDelegate<RepairShop> {
  final UnmodifiableListView<RepairShop> repairShops;

  RepairShopSearch(this.repairShops);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
        children: repairShops
            .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
            .map((shop) => ListTile(
                  title: Text(shop.name),
                  onTap: () => close(context, shop),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
        children: repairShops
            .where((a) => a.name.toLowerCase().contains(query.toLowerCase()))
            .map((activity) => ListTile(
                  title: Text(activity.name),
                  onTap: () => close(context, activity),
                ))
            .toList());
  }
}
