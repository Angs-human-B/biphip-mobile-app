class BlockedUser {
  int? id;
  String? image;
  String? firstName;
  String? lastName;


  BlockedUser({
    required this.id,
    required this.image,
    required this.firstName,
    required this.lastName
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) => BlockedUser(
    id: json["id"],
    image: json["image"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );
}
