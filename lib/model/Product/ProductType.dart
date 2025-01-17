enum ProductType { PRODUCT, GIFT_CARD }

final typeValues = EnumValues(
    {"gift_card": ProductType.GIFT_CARD, "product": ProductType.PRODUCT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }

  @override
  String toString() {
    return 'EnumValues{map: $map, reverseMap: $reverseMap}';
  }
}
