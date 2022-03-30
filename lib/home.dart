import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact/add_contact.dart';
import 'package:contact/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(children: <Widget>[
              ...snapshot.data!.docs.map(
                (document) {
                  return Container(
                    child: ContactWidget(
                        name: document['name'],
                        num: document['num'],
                        id: document.id),
                  );
                },
              ),
            ]);
          },
        ));
  }
}

class ContactWidget extends StatelessWidget {
  final String name;
  final String num;
  final String id;
  ContactWidget({required this.name, required this.num, required this.id});

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditContact(name: name, num: num, id: id)));
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) async {
                await FirebaseFirestore.instance
                    .collection('contacts')
                    .doc(id)
                    .delete();
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
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              _makePhoneCall(num);
            },
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
