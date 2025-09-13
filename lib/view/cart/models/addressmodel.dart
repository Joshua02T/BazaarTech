class AddressModel {
  final String id;
  final String place;
  final String number;
  final String address;
  final double latitude;
  final double longitude;

  AddressModel(
      {required this.id,
      required this.place,
      required this.number,
      required this.address,
      required this.latitude,
      required this.longitude});

  AddressModel copyWith({
    String? id,
    String? place,
    String? number,
    String? address,
    double? latitude,
    double? longitude,
    bool? isSelected,
  }) {
    return AddressModel(
        id: id ?? this.id,
        place: place ?? this.place,
        number: number ?? this.number,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'place': place,
        'number': number,
        'address': address,
        'latitude': latitude,
        'longitude': longitude
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'].toString(),
      place: json['label'] ?? '',
      number: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }
}
