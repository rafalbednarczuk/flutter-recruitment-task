import 'package:flutter/material.dart';
import 'package:flutter_recruitment_task/models/product_filter.dart';

const _productFilterPagePadding = EdgeInsets.all(16.0);

class ProductFilterPage extends StatelessWidget {
  final ProductFilter filter;

  const ProductFilterPage._({required this.filter});

  static Route<ProductFilter?> page(ProductFilter filter) {
    return MaterialPageRoute(
      builder: (context) => Form(
        child: ProductFilterPage._(
          filter: filter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ProductFilterPageContent(filter: filter);
  }
}

class _ProductFilterPageContent extends StatefulWidget {
  final ProductFilter filter;

  const _ProductFilterPageContent({required this.filter});

  @override
  State<_ProductFilterPageContent> createState() =>
      _ProductFilterPageContentState();
}

class _ProductFilterPageContentState extends State<_ProductFilterPageContent> {
  late ProductFilter _filter;
  late TextEditingController _productNameController;
  late bool _bestOfferOnly;
  late TextEditingController _minimumPriceController;
  late TextEditingController _maximumPriceController;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
    _productNameController = TextEditingController(text: _filter.name);
    _bestOfferOnly = _filter.bestOfferOnly;
    _minimumPriceController =
        TextEditingController(text: _filter.minimumPrice?.toString());
    _maximumPriceController =
        TextEditingController(text: _filter.maximumPrice?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter products"),
      ),
      body: ListView(
        padding: _productFilterPagePadding,
        children: [
          TextFormField(
            controller: _productNameController,
            decoration: const InputDecoration(hintText: "Product name"),
          ),
          const SizedBox(height: 8.0),
          CheckboxListTile(
            value: _bestOfferOnly,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _bestOfferOnly = value!;
              });
            },
            title: const Text("Products with best offer only"),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _minimumPriceController,
            decoration: const InputDecoration(hintText: "minimum price"),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              final doubleValue = double.tryParse(value);
              if (doubleValue == null) {
                return "Minimum price should be a valid number";
              }
              return null;
            },
          ),
          const SizedBox(height: 8.0),
          TextFormField(
              controller: _maximumPriceController,
              decoration: const InputDecoration(hintText: "maximum price"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                final doubleValue = double.tryParse(value);
                if (doubleValue == null) {
                  return "Maximum price should be a valid number";
                }
                return null;
              }),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(ProductFilter.cleared());
                  },
                  child: const Text("Clear Filters"),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _apply();
                  },
                  child: const Text("Apply"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _apply() {
    final validated = Form.of(context).validate();
    if (validated) {
      String? productName;
      bool bestOfferOnly = _bestOfferOnly;
      double? minimumPrice;
      double? maximumPrice;
      if (_productNameController.text.isNotEmpty) {
        productName = _productNameController.text;
      }
      minimumPrice = double.tryParse(_minimumPriceController.text);
      maximumPrice = double.tryParse(_maximumPriceController.text);
      final filters = ProductFilter(
        name: productName,
        bestOfferOnly: bestOfferOnly,
        minimumPrice: minimumPrice,
        maximumPrice: maximumPrice,
      );
      Navigator.of(context).pop(filters);
    }
  }
}
