import 'package:contact/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math' as math;
import 'data.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Contacts contacts = Contacts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContact(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: contacts.contact.length,
          itemBuilder: (context, index) {
            return ContactWidget(
              name: contacts.contact[index].name,
              num: contacts.contact[index].num,
            );
          }),
    );
  }
}

class ContactWidget extends StatelessWidget {
  final String name;
  final String num;

  ContactWidget({required this.name, required this.num});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                print("EDIT");
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) {
                print("DELETE");
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          title: Text(name),
          subtitle: Text(num),
          leading: Icon(
            Icons.account_circle,
            size: 40,
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
          trailing: Icon(
            Icons.call,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
