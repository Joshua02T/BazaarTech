class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final int? age;
  final int? gender;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.age,
    this.gender,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      gender: json['gender'],
      profileImage: json['profile_image'],
    );
  }
}
