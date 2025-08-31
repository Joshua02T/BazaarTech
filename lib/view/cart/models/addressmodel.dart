class AddressModel {
  final String id;
  final String place;
  final String number;
  final String address;
  final double latitude;
  final double longitude;
  bool isSelected;

  AddressModel({
    required this.id,
    required this.place,
    required this.number,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isSelected,
  });

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
      longitude: longitude ?? this.longitude,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'place': place,
        'number': number,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'isSelected': isSelected,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      place: json['place'],
      number: json['number'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isSelected: json['isSelected'],
    );
  }
}
