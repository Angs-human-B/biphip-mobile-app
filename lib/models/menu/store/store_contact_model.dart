class StoreContactModel {
    List<Contact> contacts;

    StoreContactModel({
        required this.contacts,
    });

    factory StoreContactModel.fromJson(Map<String, dynamic> json) => StoreContactModel(
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
    );
}

class Contact {
    int id;
    int pageId;
    String type;
    String value;

    Contact({
        required this.id,
        required this.pageId,
        required this.type,
        required this.value,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        pageId: json["page_id"],
        type: json["type"],
        value: json["value"],
    );
}
