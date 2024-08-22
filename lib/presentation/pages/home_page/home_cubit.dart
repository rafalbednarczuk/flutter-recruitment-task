import 'package:bloc/bloc.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';

sealed class HomeState {
  const HomeState();
}

class Loading extends HomeState {
  const Loading();
}

class Loaded extends HomeState {
  const Loaded({required this.pages, required this.scrollToProductIndex});

  final List<ProductsPage> pages;
  final int? scrollToProductIndex;
}

class Error extends HomeState {
  const Error({required this.error});

  final dynamic error;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productsRepository) : super(const Loading());

  final ProductsRepository _productsRepository;
  final List<ProductsPage> _pages = [];
  var _param = GetProductsPage(pageNumber: 1);

  Future<void> getNextPage() async {
    try {
      final totalPages = _pages.lastOrNull?.totalPages;
      if (totalPages != null && _param.pageNumber > totalPages) return;
      final newPage = await _productsRepository.getProductsPage(_param);
      _param = _param.increasePageNumber();
      _pages.add(newPage);
      emit(Loaded(pages: _pages, scrollToProductIndex: null));
    } catch (e) {
      emit(Error(error: e));
    }
  }

  Future<void> getPagesUntilProductIsFound(String productId) async {
    while (true) {
      await getNextPage();
      if (state is! Loaded) {
        return;
      }
      final products = _pages
          .map((page) => page.products)
          .expand((product) => product)
          .toList();
      final productIndex =
          products.indexWhere((product) => product.id == productId);
      if (productIndex != -1) {
        emit(Loaded(pages: _pages, scrollToProductIndex: productIndex));
        emit(Loaded(pages: _pages, scrollToProductIndex: null));
        return;
      }
      final totalPages = _pages.lastOrNull?.totalPages;
      if (totalPages != null && _param.pageNumber > totalPages) return;
    }
  }
}
