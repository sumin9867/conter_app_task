import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:conter/screens/name_textfield_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key, required this.title});

  final String title;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  String name="User" ;
  int _counter = 0;
  bool isCounterEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('userName');
    if (savedName != null) {
      setState(() {
        name = savedName;
        isCounterEnabled = true;
      });
    }
  }

  Future<void> _saveName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', newName);
  }

  Future<void> _removeName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _navigateToInputNameScreen() async {

 final updatedName = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (context) => const NameTextfieldScreen()),
      );
      await _removeName();
      setState(() {
        name = "User";
        isCounterEnabled = false;
        _counter = 0;
      });
    
     
      if (updatedName != null) {
        await _saveName(updatedName);
        setState(() {
          name = updatedName;
          isCounterEnabled = true;
        });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(



                "Welcome $name",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: _navigateToInputNameScreen,
                    icon: Icon(Icons.edit,color: Colors.black,size: 40,),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isCounterEnabled ? _decrementCounter : null,
                  child: const Icon(Icons.remove),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: isCounterEnabled ? _incrementCounter : null,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
