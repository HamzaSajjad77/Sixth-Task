import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListAnimated(),
    );
  }
}

class ListAnimated extends StatefulWidget {
  const ListAnimated({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedListState createState() => _AnimatedListState();
}

class _AnimatedListState extends State<ListAnimated> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_items[index], animation, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return ScaleTransition(
      scale: animation.drive(
        Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
      ),
      child: ListTile(
        title: Text(item),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeItem(index),
        ),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen(item: item),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _addItem() {
    final newItem = "Item ${_items.length + 1}";
    _items.insert(0, newItem);
    _listKey.currentState?.insertItem(0);
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation, index),
      duration: const Duration(milliseconds: 600),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Hero(
          tag: item,
          child: Material(
            color: Colors.transparent,
            child: Text(
              item,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}