class ProductFilter {
  ProductFilter({
    required this.name,
    required this.bestOfferOnly,
    required this.minimumPrice,
    required this.maximumPrice,
  });

  factory ProductFilter.cleared() => ProductFilter(
        name: null,
        bestOfferOnly: false,
        minimumPrice: null,
        maximumPrice: null,
      );

  final String? name;
  final bool bestOfferOnly;
  final double? minimumPrice;
  final double? maximumPrice;
}
