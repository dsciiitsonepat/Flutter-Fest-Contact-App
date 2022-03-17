class Contact {
  String name = '';
  String num = '';

  Contact({required this.name, required this.num});
}

class Contacts {
  List<Contact> contact = [];

  void updateList(Contact contact) {
    this.contact.add(contact);
    print(this.contact.length);
  }
}
