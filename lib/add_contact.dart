import 'package:flutter/material.dart';

import 'data.dart';

class AddContact extends StatelessWidget {
  AddContact({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  final Contacts contact = Contacts();

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
                  contact.updateList(Contact(
                      name: nameController.value.text,
                      num: numberController.value.text));
                  Navigator.pop(context);
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
