class UploadDealModel {
  String? title;
  String? dealLink;
  String? price;
  String? discountPrice;
  String? code;
  String? availability;
  String? location;
  String? shippingCost;
  String? shippingFrom;
  List<String>? images;
  String? description;
  String? startDate;
  String? endDate;
  String? categoryId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  UploadDealModel(
      {this.title,
        this.dealLink,
        this.price,
        this.discountPrice,
        this.code,
        this.availability,
        this.location,
        this.shippingCost,
        this.shippingFrom,
        this.images,
        this.description,
        this.startDate,
        this.endDate,
        this.categoryId,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  UploadDealModel.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    dealLink = json['deal_link']?.toString();
    price = json['price']?.toString();
    discountPrice = json['discount_price']?.toString();
    code = json['code']?.toString();
    availability = json['availability']?.toString();
    location = json['location']?.toString();
    shippingCost = json['shipping_cost']?.toString();
    shippingFrom = json['shipping_from']?.toString();
    
    // Safely handle images field
    if (json['images'] != null) {
      if (json['images'] is List) {
        images = json['images'].map((item) => item.toString()).toList();
      } else if (json['images'] is String) {
        // Handle case where images might be a single string
        images = [json['images']];
      }
    }
    
    description = json['description']?.toString();
    startDate = json['start_date']?.toString();
    endDate = json['end_date']?.toString();
    categoryId = json['category_id']?.toString();
    
    // Safely handle numeric fields
    if (json['user_id'] != null) {
      if (json['user_id'] is int) {
        userId = json['user_id'];
      } else if (json['user_id'] is String) {
        userId = int.tryParse(json['user_id']);
      }
    }
    
    if (json['id'] != null) {
      if (json['id'] is int) {
        id = json['id'];
      } else if (json['id'] is String) {
        id = int.tryParse(json['id']);
      }
    }
    
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['deal_link'] = this.dealLink;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['code'] = this.code;
    data['availability'] = this.availability;
    data['location'] = this.location;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_from'] = this.shippingFrom;
    data['images'] = this.images;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
