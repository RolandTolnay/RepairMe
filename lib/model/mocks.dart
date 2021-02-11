import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'repair_shop.dart';
import 'time_slot.dart';

class ModelMock {
  static List<TimeSlot> timeSlotListForDate(DateTime date) {
    // Sunday closed
    if (date.weekday == 7) return [];

    final interval = Duration(minutes: 15);
    final openingTime = TimeOfDay(hour: 9, minute: 0);
    final closingTime = TimeOfDay(hour: 18, minute: 0);
    final randomGenerator = Random();

    final timeSlots = <TimeSlot>[];
    var currentTime = openingTime;
    while (closingTime > currentTime) {
      final slot = TimeSlot(
        timeOfDay: currentTime,
        isBooked: randomGenerator.nextBool(),
      );
      timeSlots.add(slot);
      currentTime = currentTime.addingDuration(interval);
    }
    return timeSlots;
  }

  static List<RepairShop> get repairShopList =>
      (jsonDecode(_repairShopsJSON) as List)
          .map((json) => RepairShop.fromJson(json))
          .toList();
}

extension on TimeOfDay {
  bool operator >(TimeOfDay timeOfDay) {
    if (hour == timeOfDay.hour) {
      return minute > timeOfDay.minute;
    } else {
      return hour > timeOfDay.hour;
    }
  }

  TimeOfDay addingDuration(Duration duration) {
    final addedMinutes = duration.inMinutes + hour * 60 + minute;
    var resultHours = addedMinutes ~/ 60;
    if (resultHours > 23) {
      resultHours -= 24;
    }
    return TimeOfDay(hour: resultHours, minute: addedMinutes % 60);
  }
}

// Generated using https://mockaroo.com
const _repairShopsJSON = '''
[{
  "id": "7acdb302-1601-444f-b917-993c40966553",
  "name": "Yambee",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 4.5,
  "distance": 121,
  "price": 55
}, {
  "id": "3ef7fa66-716c-49d4-9add-9ec96c8014f1",
  "name": "Npath",
  "logoUrl": "http://dummyimage.com/100x100.png/dddddd/000000",
  "rating": 1.1,
  "distance": 62,
  "price": 60
}, {
  "id": "f80aaa70-fed0-44ca-9ab1-ef5acf0ddc7f",
  "name": "Skilith",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 3.0,
  "distance": 55,
  "price": 80
}, {
  "id": "adc9b007-ed61-4d5e-8e72-2749d5a8be41",
  "name": "Oyoba",
  "logoUrl": "http://dummyimage.com/100x100.png/dddddd/000000",
  "rating": 2.2,
  "distance": 92,
  "price": 81
}, {
  "id": "1cf57c87-a783-4582-bf23-d9f858230890",
  "name": "Skippad",
  "logoUrl": "http://dummyimage.com/100x100.png/cc0000/ffffff",
  "rating": 2.8,
  "distance": 161,
  "price": 54
}, {
  "id": "5e7070af-e253-438b-bafa-51d9cd4b9844",
  "name": "Feedbug",
  "logoUrl": "http://dummyimage.com/100x100.png/cc0000/ffffff",
  "rating": 2.2,
  "distance": 95,
  "price": 78
}, {
  "id": "6633c175-2440-4bb6-8a53-712d1d2ca142",
  "name": "Skipfire",
  "logoUrl": "http://dummyimage.com/100x100.png/cc0000/ffffff",
  "rating": 4.1,
  "distance": 10,
  "price": 23
}, {
  "id": "294f69d3-d265-4ce0-adb7-7b02c28f15e0",
  "name": "Einti",
  "logoUrl": "http://dummyimage.com/100x100.png/dddddd/000000",
  "rating": 3.6,
  "distance": 179,
  "price": 76
}, {
  "id": "9f2df6c0-253e-4933-a59b-ee4f9ed621f1",
  "name": "Dabvine",
  "logoUrl": "http://dummyimage.com/100x100.png/ff4444/ffffff",
  "rating": 4.4,
  "distance": 139,
  "price": 80
}, {
  "id": "ebf9bcae-dd04-4fad-8626-4b6d558a16ef",
  "name": "Chatterpoint",
  "logoUrl": "http://dummyimage.com/100x100.png/dddddd/000000",
  "rating": 4.5,
  "distance": 129,
  "price": 63
}, {
  "id": "946c53b6-5074-46ae-aea1-c08b3dac8d64",
  "name": "Twinder",
  "logoUrl": "http://dummyimage.com/100x100.png/cc0000/ffffff",
  "rating": 2.6,
  "distance": 173,
  "price": 17
}, {
  "id": "8dfd4c64-4c16-4461-b3f5-05cd2e10e502",
  "name": "Kamba",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 3.1,
  "distance": 26,
  "price": 66
}, {
  "id": "c1806505-e30b-45bf-b4af-2d2d2bb5f597",
  "name": "Fivebridge",
  "logoUrl": "http://dummyimage.com/100x100.png/ff4444/ffffff",
  "rating": 1.5,
  "distance": 60,
  "price": 31
}, {
  "id": "5987ed40-d137-4c2f-9e36-625c0a801ef4",
  "name": "Buzzshare",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 4.6,
  "distance": 126,
  "price": 98
}, {
  "id": "9a184f11-9915-49c7-b731-ee3399294b27",
  "name": "Yakitri",
  "logoUrl": "http://dummyimage.com/100x100.png/dddddd/000000",
  "rating": 1.3,
  "distance": 59,
  "price": 74
}, {
  "id": "ffe6ec2b-a011-44fe-9506-29f595d9f97c",
  "name": "Divavu",
  "logoUrl": "http://dummyimage.com/100x100.png/cc0000/ffffff",
  "rating": 2.7,
  "distance": 18,
  "price": 77
}, {
  "id": "71fd3a48-4147-4a82-8c0f-1090275369f0",
  "name": "Twitternation",
  "logoUrl": "http://dummyimage.com/100x100.png/ff4444/ffffff",
  "rating": 3.3,
  "distance": 190,
  "price": 18
}, {
  "id": "e6927f85-1920-4a5f-83e1-1fb16868f4fe",
  "name": "Kamba",
  "logoUrl": "http://dummyimage.com/100x100.png/ff4444/ffffff",
  "rating": 1.3,
  "distance": 25,
  "price": 82
}, {
  "id": "6c38c7a3-e2ad-41ef-a0cb-a654abe71e13",
  "name": "Latz",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 1.9,
  "distance": 136,
  "price": 23
}, {
  "id": "3c77d433-7a3d-4115-a6ad-2883b3506baf",
  "name": "Thoughtbridge",
  "logoUrl": "http://dummyimage.com/100x100.png/5fa2dd/ffffff",
  "rating": 4.2,
  "distance": 122,
  "price": 48
}]
''';
