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
  int? totalDeals;
  int? totalCoupons;
  int? totalDiscussions;
  int? totalComments;
  int? totalLikesGiven;
  int? totalDislikesGiven;

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
        this.createdAt,
        this.totalDeals,
        this.totalCoupons,
        this.totalDiscussions,
        this.totalComments,
        this.totalLikesGiven,
        this.totalDislikesGiven});

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
    totalDeals = json['total_deals'];
    totalCoupons = json['total_coupons'];
    totalDiscussions = json['total_discussions'];
    totalComments = json['total_comments'];
    totalLikesGiven = json['total_likes_given'];
    totalDislikesGiven = json['total_dislikes_given'];
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
    data['total_deals'] = this.totalDeals;
    data['total_coupons'] = this.totalCoupons;
    data['total_discussions'] = this.totalDiscussions;
    data['total_comments'] = this.totalComments;
    data['total_likes_given'] = this.totalLikesGiven;
    data['total_dislikes_given'] = this.totalDislikesGiven;
    return data;
  }
}
