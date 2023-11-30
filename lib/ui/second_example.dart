import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_package_database/data/models/car_model.dart';

class SecondExample extends StatefulWidget {
  const SecondExample({super.key});

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  TextEditingController name = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var carInfo = Hive.box('myCarBox');
    return Scaffold(
      appBar: AppBar(title: const Text('Second Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Name', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: brand,
              decoration: const InputDecoration(hintText: 'Brand', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: price,
              decoration: const InputDecoration(hintText: 'Price', border: OutlineInputBorder()),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: carInfo.values.length,
                  itemBuilder: (context, index) {
                    List<CarModel> cars = carInfo.values.toList().cast();
                    return ListTile(
                      title: Text(cars[index].name),
                      subtitle: Text(cars[index].brand),
                      trailing: Text(cars[index].price.toString()),
                      leading: CircleAvatar(child: Text('${index + 1}')),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            carInfo.add(CarModel(brand: brand.text, name: name.text, price: int.parse(price.text)));
            name.clear();
            brand.clear();
            price.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
