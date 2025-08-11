class UserLoginData {
  bool? status;
  String? message;
  String? accessToken;
  String? tokenType;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  String? address;
  String? deviceToken;
  String? createdAt;

  UserLoginData(
      {this.status,
        this.message,
        this.accessToken,
        this.tokenType,
        this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.profileImage,
        this.address,
        this.deviceToken,
        this.createdAt});

  UserLoginData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    address = json['address'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    return data;
  }
}
