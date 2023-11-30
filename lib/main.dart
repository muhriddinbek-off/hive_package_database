import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_package_database/data/adapters/car_adapter.dart';
import 'package:hive_package_database/ui/first_example.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final addDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(addDocumentDirectory.path);
  await Hive.openBox('myBox');
  Hive.registerAdapter(CarAdapter());
  await Hive.openBox('myCarBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstExamplePage(),
    );
  }
}
