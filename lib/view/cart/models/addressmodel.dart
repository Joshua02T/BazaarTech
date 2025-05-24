class AddressModel {
  final String id;
  final String place;
  final String number;
  final String address;
  bool isSelected;

  AddressModel({
    required this.id,
    required this.place,
    required this.number,
    required this.address,
    required this.isSelected,
  });

  AddressModel copyWith({
    String? id,
    String? place,
    String? number,
    String? address,
    bool? isSelected,
  }) {
    return AddressModel(
      id: id ?? this.id,
      place: place ?? this.place,
      number: number ?? this.number,
      address: address ?? this.address,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
