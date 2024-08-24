import 'package:bloc/bloc.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/product_filter.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_state.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productsRepository) : super(HomeState.initial());

  final ProductsRepository _productsRepository;
  var _param = GetProductsPage(pageNumber: 1);

  Future<void> loadFirstPageWithFilter(ProductFilter productFilter) async {
    emit(HomeState.initial().copyWith(productFilter: productFilter));
    _param = GetProductsPage(pageNumber: 1);
    await getNextPage();
  }

  Future<void> getNextPage() async {
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
      ),
    );
    try {
      final totalPages = state.pages?.lastOrNull?.totalPages;
      if (totalPages != null && _param.pageNumber > totalPages) return;
      final newPage = await _productsRepository.getProductsPage(
        param: _param,
        productFilter: state.productFilter,
      );
      _param = _param.increasePageNumber();
      final updatedPages = [...(state.pages ?? <ProductsPage>[]), newPage];
      emit(
        state.copyWith(
          pages: updatedPages,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e,
        ),
      );
    }
  }

  Future<void> getPagesUntilProductIsFound(String productId) async {
    while (true) {
      await getNextPage();
      if (state.error != null) {
        return;
      }
      final products = state.pages!
          .map((page) => page.products)
          .expand((product) => product)
          .toList();
      final productIndex =
          products.indexWhere((product) => product.id == productId);
      if (productIndex != -1) {
        emit(state.copyWith(scrollToProductIndex: productIndex));
        emit(state.copyWith(scrollToProductIndex: null));
        return;
      }
      final totalPages = state.pages!.lastOrNull?.totalPages;
      if (totalPages != null && _param.pageNumber > totalPages) return;
    }
  }
}
