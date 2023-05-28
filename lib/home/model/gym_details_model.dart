class GymDetailsModel {
  List<Pagination>? pagination;
  bool? status;
  String? message;
  List<Data>? data;

  GymDetailsModel({this.pagination, this.status, this.message, this.data});

  GymDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['pagination'] != null) {
      pagination = <Pagination>[];
      json['pagination'].forEach((v) {
        pagination!.add(new Pagination.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? pagination;
  int? limit;
  int? pages;

  Pagination({this.pagination, this.limit, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'];
    limit = json['limit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pagination'] = this.pagination;
    data['limit'] = this.limit;
    data['pages'] = this.pages;
    return data;
  }
}

class Data {
  List<SeoContent>? seoContent;
  String? pocName;
  String? pocMobile;
  String? userId;
  String? gymName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? latitude;
  String? longitude;
  String? pin;
  String? country;
  String? name;
  String? distance;
  dynamic addonCategory;
  dynamic addonCatId;
  dynamic offerType;
  dynamic offerValue;
  String? distanceText;
  String? durationText;
  String? duration;
  dynamic rating;
  dynamic? text1;
  dynamic? text2;
  dynamic? planName;
  dynamic planDuration;
  dynamic planPrice;
  dynamic? planDescription;
  dynamic? coverImage;
  List<Gallery>? gallery;
  List<Benefits>? benefits;
  String? type;
  String? description;
  String? status;
  String? slug;
  String? categoryId;
  int? totalRating;
  String? isPartial;
  int? isCash;
  String? categoryName;
  List<String>? offerDetails;
  dynamic wtfShare;
  int? isDiscount;

  Data(
      {this.seoContent,
        this.pocName,
        this.pocMobile,
        this.userId,
        this.gymName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.latitude,
        this.longitude,
        this.pin,
        this.country,
        this.name,
        this.distance,
        this.addonCategory,
        this.addonCatId,
        this.offerType,
        this.offerValue,
        this.distanceText,
        this.durationText,
        this.duration,
        this.rating,
        this.text1,
        this.text2,
        this.planName,
        this.planDuration,
        this.planPrice,
        this.planDescription,
        this.coverImage,
        this.gallery,
        this.benefits,
        this.type,
        this.description,
        this.status,
        this.slug,
        this.categoryId,
        this.totalRating,
        this.isPartial,
        this.isCash,
        this.categoryName,
        this.offerDetails,
        this.wtfShare,
        this.isDiscount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['seo_content'] != null) {
      seoContent = <SeoContent>[];
      json['seo_content'].forEach((v) {
        seoContent!.add(new SeoContent.fromJson(v));
      });
    }
    pocName = json['poc_name'];
    pocMobile = json['poc_mobile'];
    userId = json['user_id'];
    gymName = json['gym_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pin = json['pin'];
    country = json['country'];
    name = json['name'];
    distance = json['distance'];
    addonCategory = json['addon_category'];
    addonCatId = json['addon_cat_id'];
    offerType = json['offer_type'];
    offerValue = json['offer_value'];
    distanceText = json['distance_text'];
    durationText = json['duration_text'];
    duration = json['duration'];
    rating = json['rating'];
    text1 = json['text1'];
    text2 = json['text2'];
    planName = json['plan_name'];
    planDuration = json['plan_duration'];
    planPrice = json['plan_price'];
    planDescription = json['plan_description'];
    coverImage = json['cover_image'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['benefits'] != null) {
      benefits = <Benefits>[];
      json['benefits'].forEach((v) {
        benefits!.add(new Benefits.fromJson(v));
      });
    }
    type = json['type'];
    description = json['description'];
    status = json['status'];
    slug = json['slug'];
    categoryId = json['category_id'];
    totalRating = json['total_rating'];
    isPartial = json['is_partial'];
    isCash = json['is_cash'];
    categoryName = json['category_name'];
    if (json['offer_details'] != null) {
      offerDetails = <String>[];
      json['offer_details'].forEach((v) {
        offerDetails!.add(v);
      });
    }
    wtfShare = json['wtf_share'];
    isDiscount = json['is_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seoContent != null) {
      data['seo_content'] = this.seoContent!.map((v) => v.toJson()).toList();
    }
    data['poc_name'] = this.pocName;
    data['poc_mobile'] = this.pocMobile;
    data['user_id'] = this.userId;
    data['gym_name'] = this.gymName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['pin'] = this.pin;
    data['country'] = this.country;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['addon_category'] = this.addonCategory;
    data['addon_cat_id'] = this.addonCatId;
    data['offer_type'] = this.offerType;
    data['offer_value'] = this.offerValue;
    data['distance_text'] = this.distanceText;
    data['duration_text'] = this.durationText;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['text1'] = this.text1;
    data['text2'] = this.text2;
    data['plan_name'] = this.planName;
    data['plan_duration'] = this.planDuration;
    data['plan_price'] = this.planPrice;
    data['plan_description'] = this.planDescription;
    data['cover_image'] = this.coverImage;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.benefits != null) {
      data['benefits'] = this.benefits!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['description'] = this.description;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['category_id'] = this.categoryId;
    data['total_rating'] = this.totalRating;
    data['is_partial'] = this.isPartial;
    data['is_cash'] = this.isCash;
    data['category_name'] = this.categoryName;
    if (this.offerDetails != null) {
      data['offer_details'] =
          this.offerDetails!.map((v) => v).toList();
    }
    data['wtf_share'] = this.wtfShare;
    data['is_discount'] = this.isDiscount;
    return data;
  }
}

class SeoContent {
  int? id;
  String? uid;
  String? gymId;
  String? htmlContent;
  String? status;
  String? dateAdded;
  String? addedBy;
  String? lastUpdated;
  String? pageName;
  dynamic? className;

  SeoContent(
      {this.id,
        this.uid,
        this.gymId,
        this.htmlContent,
        this.status,
        this.dateAdded,
        this.addedBy,
        this.lastUpdated,
        this.pageName,
        this.className});

  SeoContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    gymId = json['gym_id'];
    htmlContent = json['html_content'];
    status = json['status'];
    dateAdded = json['date_added'];
    addedBy = json['added_by'];
    lastUpdated = json['last_updated'];
    pageName = json['page_name'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['gym_id'] = this.gymId;
    data['html_content'] = this.htmlContent;
    data['status'] = this.status;
    data['date_added'] = this.dateAdded;
    data['added_by'] = this.addedBy;
    data['last_updated'] = this.lastUpdated;
    data['page_name'] = this.pageName;
    data['class_name'] = this.className;
    return data;
  }
}

class Gallery {
  int? id;
  String? uid;
  String? gymId;
  String? categoryId;
  String? images;
  String? status;
  String? dateAdded;
  String? lastUpdated;
  String? type;

  Gallery(
      {this.id,
        this.uid,
        this.gymId,
        this.categoryId,
        this.images,
        this.status,
        this.dateAdded,
        this.lastUpdated,
        this.type});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    gymId = json['gym_id'];
    categoryId = json['category_id'];
    images = json['images'];
    status = json['status'];
    dateAdded = json['date_added'];
    lastUpdated = json['last_updated'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['gym_id'] = this.gymId;
    data['category_id'] = this.categoryId;
    data['images'] = this.images;
    data['status'] = this.status;
    data['date_added'] = this.dateAdded;
    data['last_updated'] = this.lastUpdated;
    data['type'] = this.type;
    return data;
  }
}

class Benefits {
  int? id;
  String? uid;
  String? gymId;
  String? name;
  String? breif;
  String? image;
  String? status;
  String? dateAdded;
  String? lastUpdated;
  String? images;

  Benefits(
      {this.id,
        this.uid,
        this.gymId,
        this.name,
        this.breif,
        this.image,
        this.status,
        this.dateAdded,
        this.lastUpdated,
        this.images});

  Benefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    gymId = json['gym_id'];
    name = json['name'];
    breif = json['breif'];
    image = json['image'];
    status = json['status'];
    dateAdded = json['date_added'];
    lastUpdated = json['last_updated'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['gym_id'] = this.gymId;
    data['name'] = this.name;
    data['breif'] = this.breif;
    data['image'] = this.image;
    data['status'] = this.status;
    data['date_added'] = this.dateAdded;
    data['last_updated'] = this.lastUpdated;
    data['images'] = this.images;
    return data;
  }
}