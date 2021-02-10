import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/mocks.dart';
import '../model/repair_shop.dart';

abstract class RepairShopProvider extends ChangeNotifier {
  UnmodifiableListView<RepairShop> get repairShops;

  RepairShop get selectedRepairShop;
  RepairShopSortConfiguration get sortConfiguration;

  void selectRepairShop(RepairShop repairShop);
  void sortRepairShopsBy(RepairShopSortConfiguration configuration);
}

class RMRepairShopProvider extends ChangeNotifier
    implements RepairShopProvider {
  List<RepairShop> _repairShops = [];
  RepairShop _selectedRepairShop;
  RepairShopSortConfiguration _sortConfiguration = RepairShopSortConfiguration(
      RepairShopSortCriteria.rating, SortOrder.ascending);

  @override
  RepairShop get selectedRepairShop => _selectedRepairShop;

  @override
  UnmodifiableListView<RepairShop> get repairShops =>
      UnmodifiableListView(_repairShops);

  @override
  RepairShopSortConfiguration get sortConfiguration => _sortConfiguration;

  RMRepairShopProvider() {
    _repairShops = ModelMock.repairShopList;
  }

  @override
  void selectRepairShop(RepairShop repairShop) {
    _selectedRepairShop = repairShop;
    notifyListeners();
  }

  @override
  void sortRepairShopsBy(RepairShopSortConfiguration configuration) {
    switch (configuration.criteria) {
      case RepairShopSortCriteria.rating:
        _repairShops.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case RepairShopSortCriteria.price:
        _repairShops.sort((a, b) => a.price.compareTo(b.price));
        break;
      case RepairShopSortCriteria.distance:
        _repairShops.sort((a, b) => a.distance.compareTo(b.distance));
        break;
    }
    if (configuration.order == SortOrder.descending) {
      _repairShops = _repairShops.reversed.toList();
    }
    _sortConfiguration = configuration;
    notifyListeners();
  }
}

class RepairShopSortConfiguration {
  final RepairShopSortCriteria criteria;
  final SortOrder order;

  const RepairShopSortConfiguration(this.criteria, this.order);
}

enum RepairShopSortCriteria {
  rating,
  distance,
  price,
}

extension CriteriaTitle on RepairShopSortCriteria {
  String get title {
    switch (this) {
      case RepairShopSortCriteria.rating:
        return 'Rating';
      case RepairShopSortCriteria.price:
        return 'Price';
      case RepairShopSortCriteria.distance:
        return 'Distance';
      default:
        return null;
    }
  }
}

enum SortOrder { ascending, descending }

extension OrderTitle on SortOrder {
  String get title {
    switch (this) {
      case SortOrder.ascending:
        return 'Ascending';
      case SortOrder.descending:
        return 'Descending';
      default:
        return null;
    }
  }
}
