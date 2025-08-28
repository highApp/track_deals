class HomeDataModel {
  List<DataUsers>? dataUsers;

  HomeDataModel({this.dataUsers});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data_users'] != null) {
      dataUsers = <DataUsers>[];
      json['data_users'].forEach((v) {
        dataUsers!.add(new DataUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataUsers != null) {
      data['data_users'] = this.dataUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUsers {
  List<Deals>? deals;

  DataUsers({this.deals});

  DataUsers.fromJson(Map<String, dynamic> json) {
    if (json['deals'] != null) {
      deals = <Deals>[];
      json['deals'].forEach((v) {
        deals!.add(new Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deals != null) {
      data['deals'] = this.deals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deals {
  int? id;
  String? title;
  String? price;
  String? discountPrice;
  String? dealLink;
  String? availability;
  String? location;
  String? code;
  Null? shippingCost;
  String? shippingFrom;
  List<String>? images;
  String? description;
  String? startDate;
  String? endDate;
  String? categoryId;
  int? likes;
  int? dislikes;
  int? commentsCount;
  User? user;

  Deals(
      {this.id,
        this.title,
        this.price,
        this.discountPrice,
        this.dealLink,
        this.availability,
        this.location,
        this.code,
        this.shippingCost,
        this.shippingFrom,
        this.images,
        this.description,
        this.startDate,
        this.endDate,
        this.categoryId,
        this.likes,
        this.dislikes,
        this.commentsCount,
        this.user});

  Deals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discountPrice = json['discount_price'];
    dealLink = json['deal_link'];
    availability = json['availability'];
    location = json['location'];
    code = json['code'];
    shippingCost = json['shipping_cost'];
    shippingFrom = json['shipping_from'];
    images = json['images'].cast<String>();
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    categoryId = json['category_id'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    commentsCount = json['comments_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['deal_link'] = this.dealLink;
    data['availability'] = this.availability;
    data['location'] = this.location;
    data['code'] = this.code;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_from'] = this.shippingFrom;
    data['images'] = this.images;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['category_id'] = this.categoryId;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['comments_count'] = this.commentsCount;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  Null? address;
  String? deviceToken;
  String? createdAt;
  int? totalDeals;
  int? totalCoupons;
  int? totalDiscussions;
  int? totalComments;
  int? totalLikesGiven;
  int? totalDislikesGiven;

  User(
      {this.id,
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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
