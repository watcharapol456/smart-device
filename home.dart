import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/product_repository.dart';
import 'supplemental/asymmetric _view.dart';

class HomePage extends StatelessWidget {

// TODO: Add a variable for Category (104)

  final Category category;

  const HomePage({this.category = Category.all});

  @override

  Widget build(BuildContext context) {

// TODO: Pass Category variable to AsymmetricView (104)

    return AsymmetricView(products: ProductsRepository.loadProducts(category));

  }

}




  List<Card> _buildGridCards(BuildContext context) {

    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {

      return const <Card>[];

    }

    final ThemeData theme = Theme.of(context);

    final NumberFormat formatter = NumberFormat.simpleCurrency(

        locale: Localizations.localeOf(context).toString());

    return products.map((product) {

      return Card(

        clipBehavior: Clip.antiAlias,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            AspectRatio(

              aspectRatio: 18 / 11,

              child: Image.asset(

                product.assetName,

                package: product.assetPackage,

                fit: BoxFit.fitWidth,

              ),

            ),

            Expanded(

              child: Padding(

                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[

                    Text(

                      product.name,

                      style: theme.textTheme.labelLarge, //former textTheme.button

                      softWrap: false,

                      overflow: TextOverflow.ellipsis,

                      maxLines: 1,

                    ),

                    const SizedBox(height: 4.0),

                    Text(

                      formatter.format(product.price),

                      style: theme.textTheme.bodySmall, // formar textThem.caption

                    ),
                  ],

                ),

              ),

            ),

          ],

        ),

      );

    }).toList();

  }

