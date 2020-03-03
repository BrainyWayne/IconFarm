class UserProfile {
  String id;
  String number;
  String name;
  String img;
  String email;

  UserProfile({this.id, this.number, this.name,this.img, this.email});

  UserProfile.fromMap(Map snapshot,String id) :
        id = id ?? '',
        number = snapshot['number'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '',
        email = snapshot['email'] ?? '';

  toJson() {
    return {
      "number": number,
      "name": name,
      "img": img,
      "email": email,
    };
  }
}