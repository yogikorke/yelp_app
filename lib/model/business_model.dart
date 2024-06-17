import 'package:equatable/equatable.dart';

class BusinessModel extends Equatable {
  final String? id;
  final String? alias;
  final String? name;
  final String? imageUrl;
  final bool? isClosed;
  final String? url;
  final int? reviewCount;
  final List<Categories>? categories;
  final double? rating;
  final Coordinates? coordinates;
  final List<String>? transactions;
  final String? price;
  final Location? location;
  final String? phone;
  final String? displayPhone;
  final double? distance;

  const BusinessModel(
      {this.id,
      this.alias,
      this.name,
      this.imageUrl,
      this.isClosed,
      this.url,
      this.reviewCount,
      this.categories,
      this.rating,
      this.coordinates,
      this.transactions,
      this.price,
      this.location,
      this.phone,
      this.displayPhone,
      this.distance});

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      alias: json['alias'],
      name: json['name'],
      imageUrl: json['image_url'],
      isClosed: json['is_closed'],
      url: json['url'],
      reviewCount: json['review_count'],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      phone: json['phone'],
      displayPhone: json['display_phone'],
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alias': alias,
      'name': name,
      'image_url': imageUrl,
      'is_closed': isClosed,
      'url': url,
      'review_count': reviewCount,
      'categories': categories?.map((e) => e.toJson()).toList(),
      'rating': rating,
      'coordinates': coordinates?.toJson(),
      'transactions': transactions,
      'price': price,
      'location': location?.toJson(),
      'phone': phone,
      'display_phone': displayPhone,
      'distance': distance,
    };
  }

  @override
  List<Object?> get props => [
        id,
        alias,
        name,
        imageUrl,
        isClosed,
        url,
        reviewCount,
        categories,
        rating,
        coordinates,
        transactions,
        price,
        location,
        phone,
        displayPhone,
        distance,
      ];
}


class Categories extends Equatable {
  final String? alias;
  final String? title;

  const Categories({this.alias, this.title});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      alias: json['alias'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': alias,
      'title': title,
    };
  }

  @override
  List<Object?> get props => [alias, title];
}

class Coordinates extends Equatable {
  final double? latitude;
  final double? longitude;

  const Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [latitude, longitude];
}

class Location extends Equatable {
  final String? address1;
  final String? address2;
  final String? address3;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? state;
  final List<String>? displayAddress;

  const Location(
      {this.address1,
      this.address2,
      this.address3,
      this.city,
      this.zipCode,
      this.country,
      this.state,
      this.displayAddress});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      city: json['city'],
      zipCode: json['zip_code'],
      country: json['country'],
      state: json['state'],
      displayAddress: (json['display_address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'city': city,
      'zip_code': zipCode,
      'country': country,
      'state': state,
      'display_address': displayAddress,
    };
  }

  @override
  List<Object?> get props => [
        address1,
        address2,
        address3,
        city,
        zipCode,
        country,
        state,
        displayAddress,
      ];
}
