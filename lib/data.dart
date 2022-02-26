class Contact {
  String name = '';
  String num = '';

  Contact({required this.name, required this.num});
}

class Contacts {
  List<Contact> contact = [
    Contact(name: "Ayush Singh", num: "9876543210"),
    Contact(name: "Rishab Sinha", num: "9123456789"),
    Contact(name: "Aditya Chaudhary", num: "9234567887"),
    Contact(name: "Vansh Kela", num: "9876543781"),
  ];

  void updateList(Contact contact) {
    this.contact.add(contact);
    print(this.contact.length);
  }
}
