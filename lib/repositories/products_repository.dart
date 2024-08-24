//
// Don't modify this file please!
//
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_recruitment_task/models/get_products_page.dart';
import 'package:flutter_recruitment_task/models/product_filter.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';

const _fakeDelay = Duration(milliseconds: 500);

abstract class ProductsRepository {
  Future<ProductsPage> getProductsPage({
    required GetProductsPage param,
    ProductFilter? productFilter,
  });
}

class MockedProductsRepository implements ProductsRepository {
  @override
  Future<ProductsPage> getProductsPage({
    required GetProductsPage param,
    ProductFilter? productFilter,
  }) async {
    final path = 'assets/mocks/products_pages/${param.pageNumber}.json';
    final data = await rootBundle.loadString(path);
    final json = jsonDecode(data);
    var page = ProductsPage.fromJson(json);
    var products = page.products;
    if (productFilter != null) {
      if (productFilter.name != null) {
        final productNameFilterLowercase = productFilter.name!.toLowerCase();
        products = products
            .where((product) =>
                product.name.toLowerCase().contains(productNameFilterLowercase))
            .toList();
      }
      if (productFilter.bestOfferOnly) {
        products =
            products.where((product) => product.offer.isBest == true).toList();
      }
      if (productFilter.minimumPrice != null) {
        products = products
            .where((product) =>
                product.offer.regularPrice.amount >=
                productFilter.minimumPrice!)
            .toList();
      }
      if (productFilter.maximumPrice != null) {
        products = products
            .where((product) =>
                product.offer.regularPrice.amount <=
                productFilter.maximumPrice!)
            .toList();
      }
      page = ProductsPage(
        totalPages: page.totalPages,
        pageNumber: page.pageNumber,
        pageSize: page.pageSize,
        products: products,
      );
    }

    return Future.delayed(_fakeDelay, () => page);
  }
}
