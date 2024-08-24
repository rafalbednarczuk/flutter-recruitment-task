import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/models/products_page.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_state.dart';
import 'package:flutter_recruitment_task/presentation/pages/products_filter_page/product_filter_page.dart';
import 'package:flutter_recruitment_task/presentation/widgets/big_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const _mainPadding = EdgeInsets.all(16.0);
const _scrollToProductDuration = Duration(milliseconds: 300);

class HomePage extends StatefulWidget {
  final String? scrollToProductId;

  const HomePage({super.key, this.scrollToProductId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ItemScrollController _itemScrollController;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final cubit = HomeCubit(RepositoryProvider.of(context));
        if (widget.scrollToProductId != null) {
          cubit.getPagesUntilProductIsFound(widget.scrollToProductId!);
        } else {
          cubit.getNextPage();
        }
        return cubit;
      },
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (!state.isLoading && state.scrollToProductIndex != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _itemScrollController.scrollTo(
                index: state.scrollToProductIndex!,
                duration: _scrollToProductDuration,
                curve: Curves.easeInOut,
              );
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const BigText('Products'),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Builder(
                  builder: (context) => OutlinedButton(
                    onPressed: () async {
                      final currentFilter = BlocProvider.of<HomeCubit>(context)
                          .state
                          .productFilter;
                      final newFilter = await Navigator.of(context)
                          .push(ProductFilterPage.page(currentFilter));
                      if (!context.mounted) return;
                      if (newFilter != null) {
                        BlocProvider.of<HomeCubit>(context)
                            .loadFirstPageWithFilter(newFilter);
                      }
                    },
                    child: const Text("Filter"),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: _mainPadding,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.isLoading && state.pages == null) {
                  return const BigText('Loading...');
                }
                if (state.error != null) {
                  return BigText('Error: ${state.error}');
                }
                return _LoadedWidget(
                  pages: state.pages!,
                  itemScrollController: _itemScrollController,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({
    required this.pages,
    required this.itemScrollController,
  });

  final List<ProductsPage> pages;
  final ItemScrollController itemScrollController;

  @override
  Widget build(BuildContext context) {
    final products = pages
        .map((page) => page.products)
        .expand((product) => product)
        .toList();
    return ScrollablePositionedList.separated(
      itemScrollController: itemScrollController,
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index == products.length) {
          return const _GetNextPageButton();
        }
        return _ProductCard(products[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(product.name),
          _Tags(product: product),
        ],
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: product.tags.map(_TagWidget.new).toList(),
    );
  }
}

class _TagWidget extends StatelessWidget {
  const _TagWidget(this.tag);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        color: MaterialStateProperty.all(tag.color),
        label: Text(
          tag.label,
          style: TextStyle(color: tag.labelColor),
        ),
      ),
    );
  }
}

class _GetNextPageButton extends StatelessWidget {
  const _GetNextPageButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<HomeCubit>().getNextPage,
      child: const BigText('Get next page'),
    );
  }
}
