import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  EditContact({required this.id, required this.name, required this.num});
  final String id;
  final String name;
  final String num;
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController numberController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    numberController = TextEditingController(text: widget.num);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
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
              SizedBox(
                height: 30,
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
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseFirestore.instance
                          .collection('contacts')
                          .doc(widget.id)
                          .update({
                        "name": nameController.value.text,
                        "num": numberController.value.text
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text("Update Contact"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
