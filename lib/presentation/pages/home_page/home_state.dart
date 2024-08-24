import 'package:flutter_recruitment_task/models/product_filter.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<ProductsPage>? pages,
    required int? scrollToProductIndex,
    required bool isLoading,
    required Object? error,
    required ProductFilter productFilter,
  }) = _HomeState;

  factory HomeState.initial() {
    return HomeState(
      pages: null,
      scrollToProductIndex: null,
      isLoading: true,
      error: null,
      productFilter: ProductFilter.cleared(),
    );
  }
}
