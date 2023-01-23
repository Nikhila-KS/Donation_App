class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? image_url;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.image_url});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      image_url: map['image_url'],
    );
  }


  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'image_url': image_url,
    };
  }
}