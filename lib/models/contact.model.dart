class ContactModel {
  int id = 0;
  String name = "";
  String email = "";
  String phone = "";
  String image = "https://placehold.it/200";
  String addressLine1 = "";
  String addressLine2 = "";
  String latLng = "";

  ContactModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.addressLine1,
    this.addressLine2,
    this.latLng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'latLng': latLng,
    };
  }
}
