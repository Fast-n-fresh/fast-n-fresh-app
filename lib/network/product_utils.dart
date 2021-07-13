import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/product_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUtils {
  String categoryCreation;
  String productCreation;

  Future<ProductCategory> createCategory(ProductCategory category) async {
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
      if (response.statusCode == 400) {
        categoryCreation = json.decode(response.body)['error'];
      } else {
        categoryCreation = 'Category Created Successfully!';
      }
      return ProductCategory.fromJson(json.decode(response.body));
    });
  }

  Future<Product> createProduct(Product product) async {
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
      return Product.fromJson(json.decode(response.body));
    });
  }

  Future<List<ProductCategory>> getCategories() async {
    List<ProductCategory> categories = [];
    final response = await http.get(
      Uri.https(BASE_URL, USER_GET_CATEGORIES),
    );

    var extract = json.decode(response.body);
    var categoriesJson = extract['categoryList'];
    if (response.statusCode == 200) {
      for (Map i in categoriesJson) {
        categories.add(ProductCategory.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t fetch data');
    }
    return categories;
  }

  Future<List<Product>> getProducts(String categoryId) async {
    List<Product> products = [];
    final response = await http.get(
      Uri.https(BASE_URL, USER_GET_PRODUCTS + categoryId),
    );
    var extract = json.decode(response.body);
    var categoriesJson = extract['categoryList'];
    if (response.statusCode == 200) {
      for (Map i in categoriesJson) {
        products.add(Product.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t fetch data');
    }
    return products;
  }
}
