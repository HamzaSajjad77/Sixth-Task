import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(title:const Text('Item List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dataProvider.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataProvider.items[index]),
                  trailing: IconButton(
                    icon:const Icon(Icons.delete),
                    onPressed: () {
                      dataProvider.removeItem(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:const InputDecoration(labelText: 'Enter item'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      dataProvider.addItem(_controller.text);
                      _controller.clear();
                    }
                  },
                  child:const Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}