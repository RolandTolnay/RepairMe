import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/repair_shop.dart';
import '../service/repair_shop_provider.dart';
import 'repair_shop_search.dart';

class RepairShopListPage extends StatelessWidget {
  final ValueChanged<RepairShop> onRepairShopSelected;

  const RepairShopListPage({this.onRepairShopSelected, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RepairShopProvider>();

    final searchButton = OutlineButton.icon(
      icon: Icon(Icons.search),
      label: Text('Search'),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      textColor: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        final repairShop = await showSearch(
            context: context, delegate: RepairShopSearch(provider.repairShops));
        provider.selectRepairShop(repairShop);
        onRepairShopSelected?.call(repairShop);
      },
    );

    final sortButton = OutlineButton.icon(
      icon: Icon(Icons.sort),
      label: Text('Sort'),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      textColor: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        final sortConfiguration = await showDialog<RepairShopSortConfiguration>(
          context: context,
          builder: (_) => _SortDialog(provider.sortConfiguration),
        );
        if (sortConfiguration != null) {
          provider.sortRepairShopsBy(sortConfiguration);
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [searchButton, sortButton],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(children: [
            ...provider.repairShops
                .map((shop) => _RepairShopItem(
                      shop,
                      isSelected: shop == provider.selectedRepairShop,
                      onTapped: () {
                        provider.selectRepairShop(shop);
                        onRepairShopSelected?.call(shop);
                      },
                    ))
                .toList()
          ]),
        ),
      ],
    );
  }
}

class _RepairShopItem extends StatelessWidget {
  const _RepairShopItem(
    this.repairShop, {
    this.onTapped,
    this.isSelected = false,
    Key key,
  }) : super(key: key);

  final RepairShop repairShop;
  final bool isSelected;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final rating = Row(
      children: [
        Icon(Icons.star, size: 12, color: Theme.of(context).disabledColor),
        Text('${repairShop.rating}')
      ],
    );

    return ListTile(
      tileColor: isSelected ? Theme.of(context).highlightColor : null,
      leading: SizedBox(
        height: 50,
        width: 50,
        child: FadeInImage.memoryNetwork(
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
          imageErrorBuilder: (_, error, ___) {
            print('Failed loading image: $error');
            return CircleAvatar(backgroundColor: Colors.black12);
          },
          image: repairShop.logoUrl,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(repairShop.name),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rating,
            Text('${repairShop.distance} ly'),
            Text('${repairShop.price} ฿'),
          ],
        ),
      ),
      onTap: () => onTapped?.call(),
    );
  }
}

class _SortDialog extends StatefulWidget {
  final RepairShopSortConfiguration sortConfiguration;

  const _SortDialog(this.sortConfiguration, {Key key}) : super(key: key);

  @override
  __SortDialogState createState() => __SortDialogState();
}

class __SortDialogState extends State<_SortDialog> {
  RepairShopSortCriteria _criteria;
  SortOrder _order;

  @override
  void initState() {
    super.initState();

    _criteria = widget.sortConfiguration.criteria;
    _order = widget.sortConfiguration.order;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...RepairShopSortCriteria.values.map((criteria) {
            return ListTile(
                title: Text(criteria.title),
                leading: Radio(
                  value: criteria,
                  groupValue: _criteria,
                  onChanged: (value) {
                    setState(() {
                      _criteria = criteria;
                    });
                  },
                ));
          }).toList(),
          const Divider(thickness: 2.0),
          ...SortOrder.values.map((order) {
            return ListTile(
                title: Text(order.title),
                leading: Radio(
                  value: order,
                  groupValue: _order,
                  onChanged: (value) {
                    setState(() {
                      _order = order;
                    });
                  },
                ));
          }).toList(),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('CANCEL')),
        FlatButton(
            onPressed: () {
              final configuration =
                  RepairShopSortConfiguration(_criteria, _order);
              Navigator.pop(context, configuration);
            },
            child: Text('SORT'))
      ],
    );
  }
}
