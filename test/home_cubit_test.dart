import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/product_filter.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_state.dart';
import 'package:flutter_recruitment_task/repositories/products_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

class GetProductsPageFake extends Fake implements GetProductsPage {}

class ProductFilterFake extends Fake implements ProductFilter {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(HomeCubit, () {
    late ProductsRepository successfulProductsRepository;
    late ProductsRepository unsuccessfulProductsRepository;
    late HomeCubit successfulCubit;
    late HomeCubit unsuccessfulCubit;

    setUp(() {
      registerFallbackValue(GetProductsPageFake());
      successfulProductsRepository = MockedProductsRepository();
      unsuccessfulProductsRepository = MockProductsRepository();
      when(() => unsuccessfulProductsRepository.getProductsPage(
              param: any(named: "param"),
              productFilter: any(named: "productFilter")))
          .thenThrow(Exception("An exception"));
      successfulCubit = HomeCubit(successfulProductsRepository);
      unsuccessfulCubit = HomeCubit(unsuccessfulProductsRepository);
    });

    test("initial state only", () {
      expect(successfulCubit.state, HomeState.initial());
    });

    blocTest<HomeCubit, HomeState>("successful single page load",
        build: () => successfulCubit,
        act: (cubit) => cubit.getNextPage(),
        expect: () => [
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", true)
                  .having((state) => state.error, "error", null),
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", false)
                  .having((state) => state.error, "error", null)
                  .having((state) => state.pages!.length, "pages", 1)
                  .having((state) => state.pages![0].products.length,
                      "products", greaterThan(0)),
            ]);

    blocTest<HomeCubit, HomeState>("unsuccessful single page load",
        build: () => unsuccessfulCubit,
        act: (cubit) => cubit.getNextPage(),
        expect: () => [
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", true)
                  .having((state) => state.error, "error", null),
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", false)
                  .having((state) => state.error, "error", isA<Exception>())
            ]);

    blocTest<HomeCubit, HomeState>(
        "successful pages load and scroll to found product",
        build: () => successfulCubit,
        act: (cubit) => cubit.getPagesUntilProductIsFound("55"),
        expect: () async {
          final firstPage = await successfulProductsRepository.getProductsPage(
              param: GetProductsPage(pageNumber: 1));
          final secondPage = await successfulProductsRepository.getProductsPage(
              param: GetProductsPage(pageNumber: 2));
          final products = [...firstPage.products, ...secondPage.products];
          final indexOfProduct55 =
              products.indexWhere((product) => product.id == "55");
          return [
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", true),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", false)
                .having((state) => state.pages!.length, "pages", 1)
                .having((state) => state.pages![0].products.length, "products",
                    greaterThan(0)),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", true),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", false)
                .having((state) => state.pages!.length, "pages", 2)
                .having((state) => state.pages![1].products.length, "products",
                    greaterThan(0)),
            isA<HomeState>().having((state) => state.scrollToProductIndex,
                "scrollToProductIndex", indexOfProduct55),
            isA<HomeState>().having((state) => state.scrollToProductIndex,
                "scrollToProductIndex", null),
          ];
        });

    blocTest<HomeCubit, HomeState>(
        "unsuccessful pages load and product not found",
        build: () => successfulCubit,
        act: (cubit) => cubit.getPagesUntilProductIsFound("NOT_EXISITNG_ID"),
        expect: () async {
          return [
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", true),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", false)
                .having((state) => state.pages!.length, "pages", 1)
                .having((state) => state.pages![0].products.length, "products",
                    greaterThan(0)),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", true),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", false)
                .having((state) => state.pages!.length, "pages", 2)
                .having((state) => state.pages![1].products.length, "products",
                    greaterThan(0)),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", true),
            isA<HomeState>()
                .having((state) => state.isLoading, "isLoading", false)
                .having((state) => state.pages!.length, "pages", 3)
                .having((state) => state.pages![2].products.length, "products",
                    greaterThan(0)),
          ];
        });

    blocTest<HomeCubit, HomeState>(
        "unsuccessful pages load and try to find a product",
        build: () => unsuccessfulCubit,
        act: (cubit) => cubit.getPagesUntilProductIsFound("55"),
        expect: () => [
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", true)
                  .having((state) => state.error, "error", null),
              isA<HomeState>()
                  .having((state) => state.isLoading, "isLoading", false)
                  .having((state) => state.error, "error", isA<Exception>())
            ]);
  });
}
