class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image =
      'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4';

  bool? isEmailVerified;

  UserModel({
    required this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'] == null
        ? json['image']
        : 'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4';
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
