import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_package_database/ui/second_example.dart';

class FirstExamplePage extends StatefulWidget {
  const FirstExamplePage({super.key});

  @override
  State<FirstExamplePage> createState() => _FirstExamplePageState();
}

class _FirstExamplePageState extends State<FirstExamplePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController changeController = TextEditingController();
  var textBox = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondExample()));
      }),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/img.jpeg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Todo App Example',
              style: TextStyle(fontSize: 25, color: Colors.black87, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 50, left: 20, bottom: 10),
              child: TextField(
                style: const TextStyle(fontSize: 17, color: Colors.black),
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Create value',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                  minimumSize: const MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.green),
                ),
                onPressed: () {
                  setState(() {
                    if (nameController.text != '') {
                      textBox.add(nameController.text);
                    }
                    nameController.text = '';
                  });
                },
                child: const Text('Add element')),
            const SizedBox(height: 30),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: textBox.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 15,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          iconColor: Colors.green,
                          onLongPress: () {
                            setState(() {});
                            changeController.text = textBox.values.toList()[index];
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Changate'),
                                    content: TextField(
                                      maxLines: 5,
                                      controller: changeController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cansel')),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              textBox.putAt(index, changeController.text);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text('Yes')),
                                    ],
                                  );
                                });
                          },
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(textBox.values.toList()[index]),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  textBox.deleteAt(index);
                                });
                              },
                              icon: const Icon(Icons.remove_circle_outline)),
                        ),
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
