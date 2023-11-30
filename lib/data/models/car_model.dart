import 'package:hive_flutter/adapters.dart';

class CarModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(0)
  String brand;
  @HiveField(1)
  num price;
  CarModel({
    required this.brand,
    required this.name,
    required this.price,
  });
}
