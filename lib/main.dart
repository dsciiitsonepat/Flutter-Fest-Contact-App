import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contact App"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Contact Added");
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Contact App List",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
