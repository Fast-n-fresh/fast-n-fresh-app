import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/categories_model.dart';
import 'package:natures_delicacies/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUtils {
  String categoryCreation;
  String productCreation;

  Future<CategoriesModel> createCategory(CategoriesModel category) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $adminToken', 'Content-Type': 'application/json'};

    return await http
        .post(
      Uri.https(BASE_URL, CREATE_CATEGORY_URL),
      body: jsonEncode(category.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        categoryCreation = 'Category Created Successfully!';
      } else {
        categoryCreation = json.decode(response.body)['error'];
      }
      return CategoriesModel.fromJson(json.decode(response.body));
    });
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $adminToken', 'Content-Type': 'application/json'};

    return await http
        .post(
      Uri.https(BASE_URL, CREATE_PRODUCT_URL),
      body: jsonEncode(product.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        productCreation = 'Product Created Successfully!';
      } else {
        productCreation = json.decode(response.body)['error'];
      }
      return ProductModel.fromJson(json.decode(response.body));
    });
  }
}
