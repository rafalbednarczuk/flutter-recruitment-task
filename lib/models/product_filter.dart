import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter.freezed.dart';

@freezed
class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    required String? name,
    required bool bestOfferOnly,
    required double? minimumPrice,
    required double? maximumPrice,
  }) = _ProductFilter;

  factory ProductFilter.cleared() => const ProductFilter(
        name: null,
        bestOfferOnly: false,
        minimumPrice: null,
        maximumPrice: null,
      );
}
