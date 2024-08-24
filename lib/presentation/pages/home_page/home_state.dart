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
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      pages: null,
      scrollToProductIndex: null,
      isLoading: true,
      error: null,
    );
  }
}
