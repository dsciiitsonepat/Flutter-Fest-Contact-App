import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class AddContact extends StatelessWidget {
  AddContact({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  Future<void> updateData(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        "name": nameController.value.text,
        "num": numberController.value.text
      });
      Navigator.pop(context);
    } catch (e) {
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Name"),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Name';
                }
                return null;
              },
            ),
            Text("Number"),
            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateData(context);
                }
              },
              child: Text("Add Contact"),
            ),
          ],
        ),
      ),
    );
  }
}
