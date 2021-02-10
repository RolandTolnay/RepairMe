import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairme/ui/repair_shop_search.dart';
import 'package:transparent_image/transparent_image.dart';

import '../service/repair_shop_provider.dart';

class RepairShopListPage extends StatelessWidget {
  const RepairShopListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RepairShopProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlineButton.icon(
              icon: Icon(Icons.search),
              label: Text('Search'),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2),
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                final repairShop = await showSearch(
                    context: context,
                    delegate: RepairShopSearch(provider.repairShops));
                provider.selectRepairShop(repairShop);
              },
            ),
            OutlineButton.icon(
              icon: Icon(Icons.sort),
              label: Text('Sort'),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2),
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                final sortConfiguration =
                    await showDialog<RepairShopSortConfiguration>(
                  context: context,
                  builder: (_) => _SortDialog(provider.sortConfiguration),
                );
                if (sortConfiguration != null) {
                  provider.sortRepairShopsBy(sortConfiguration);
                }
              },
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView(children: [
            ...provider.repairShops.map((shop) {
              final rating = Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Theme.of(context).disabledColor,
                  ),
                  Text('${shop.rating}')
                ],
              );

              return ListTile(
                tileColor: shop == provider.selectedRepairShop
                    ? Theme.of(context).highlightColor
                    : null,
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return CircleAvatar(backgroundColor: Colors.black12);
                    },
                    image: shop.logoUrl,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(shop.name),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rating,
                      Text('${shop.distance} ly'),
                      Text('${shop.price} ฿'),
                    ],
                  ),
                ),
                onTap: () {
                  provider.selectRepairShop(shop);
                },
              );
            }).toList()
          ]),
        ),
      ],
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
