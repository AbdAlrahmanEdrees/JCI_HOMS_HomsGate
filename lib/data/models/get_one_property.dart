class GetOneProperty {
  String? id;
  String? user;
  String? userType;
  String? createdAt;
  String? updatedAt;
  String? profilePhoto;
  String? phoneNumber;
  String? title;
  String? slug;
  String? refCode;
  String? description;
  Location? location;
  int? propertyNumber;
  int? price;
  String? plotArea;
  int? totalFloors;
  int? floorNumber;
  int? bedrooms;
  int? bathrooms;
  int? kitchens;
  int? livingRooms;
  String? propertyStatus;
  String? propertyType;
  String? ownershipType;
  String? covering;
  bool? elevator;
  bool? pool;
  bool? solarPanels;
  String? furnishing;
  String? direction;
  int? totalRooms;
  String? rentType;
  String? coverPhoto;
  bool? publishedStatus;
  int? views;
  List<Images>? images;

  GetOneProperty(
      {this.id,
        this.user,
        this.userType,
        this.createdAt,
        this.updatedAt,
        this.profilePhoto,
        this.phoneNumber,
        this.title,
        this.slug,
        this.refCode,
        this.description,
        this.location,
        this.propertyNumber,
        this.price,
        this.plotArea,
        this.totalFloors,
        this.floorNumber,
        this.bedrooms,
        this.bathrooms,
        this.kitchens,
        this.livingRooms,
        this.propertyStatus,
        this.propertyType,
        this.ownershipType,
        this.covering,
        this.elevator,
        this.pool,
        this.solarPanels,
        this.furnishing,
        this.direction,
        this.totalRooms,
        this.rentType,
        this.coverPhoto,
        this.publishedStatus,
        this.views,
        this.images});

  GetOneProperty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhoto = json['profile_photo'];
    phoneNumber = json['phone_number'];
    title = json['title'];
    slug = json['slug'];
    refCode = json['ref_code'];
    description = json['description'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    propertyNumber = json['property_number'];
    price = json['price'];
    plotArea = json['plot_area'];
    totalFloors = json['total_floors'];
    floorNumber = json['floor_number'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    kitchens = json['kitchens'];
    livingRooms = json['living_rooms'];
    propertyStatus = json['property_status'];
    propertyType = json['property_type'];
    ownershipType = json['ownership_type'];
    covering = json['covering'];
    elevator = json['elevator'];
    pool = json['pool'];
    solarPanels = json['solar_panels'];
    furnishing = json['furnishing'];
    direction = json['direction'];
    totalRooms = json['total_rooms'];
    rentType = json['rent_type'];
    coverPhoto = json['cover_photo'];
    publishedStatus = json['published_status'];
    views = json['views'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_photo'] = profilePhoto;
    data['phone_number'] = phoneNumber;
    data['title'] = title;
    data['slug'] = slug;
    data['ref_code'] = refCode;
    data['description'] = description;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['property_number'] = propertyNumber;
    data['price'] = price;
    data['plot_area'] = plotArea;
    data['total_floors'] = totalFloors;
    data['floor_number'] = floorNumber;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['kitchens'] = kitchens;
    data['living_rooms'] = livingRooms;
    data['property_status'] = propertyStatus;
    data['property_type'] = propertyType;
    data['ownership_type'] = ownershipType;
    data['covering'] = covering;
    data['elevator'] = elevator;
    data['pool'] = pool;
    data['solar_panels'] = solarPanels;
    data['furnishing'] = furnishing;
    data['direction'] = direction;
    data['total_rooms'] = totalRooms;
    data['rent_type'] = rentType;
    data['cover_photo'] = coverPhoto;
    data['published_status'] = publishedStatus;
    data['views'] = views;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? city;
  String? region;
  String? street;

  Location({this.city, this.region, this.street});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    region = json['region'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['region'] = region;
    data['street'] = street;
    return data;
  }
}

class Images {
  int? pkid;
  String? image;
  int? property;

  Images({this.pkid, this.image, this.property});

  Images.fromJson(Map<String, dynamic> json) {
    pkid = json['pkid'];
    image = json['image'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pkid'] = pkid;
    data['image'] = image;
    data['property'] = property;
    return data;
  }
}