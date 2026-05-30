import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../models/product_model.dart';

class ProductService {

  Future<List<ProductModel>>
      getProducts() async {

    try {

      final response = await http.get(
        Uri.parse(
          'https://fakestoreapi.com/products',
        ),
      );

      if (response.statusCode == 200) {

        final List data =
            jsonDecode(response.body);

        return data
            .map(
              (item) =>
                  ProductModel.fromJson(
                item,
              ),
            )
            .toList();
      }

      throw Exception(
        'Erro ao buscar produtos',
      );

    } catch (e) {

      throw Exception(
        'Falha na conexão',
      );
    }
  }
}