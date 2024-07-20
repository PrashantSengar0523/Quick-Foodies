class UserModel {
  final String id;
  final String email;
  String firstName;
  String lastName;
  String phone;
  String ?profile;

  UserModel({
      required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phone,
      this.profile
      });

  Map<String,dynamic> toJson(){
    return{
      'ID':id,
      'FirstName':firstName,
      'LastName':lastName,
      'Email':email,
      'Phone':phone,
      'Profile':profile,
    };
  }

// Create a UserModel object from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['ID']??'',
      firstName: data['FirstName']??'',
      lastName: data['LastName']??'',
      email: data['Email']??'',
      phone: data['Phone']??'',
      profile: data['Profile']??'',
    );
  }

}
