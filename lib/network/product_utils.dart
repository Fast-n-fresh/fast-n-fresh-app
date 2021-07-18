import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/order.dart';
import 'package:natures_delicacies/models/previous_orders.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/product_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUtils {
  String categoryCreation;
  String productCreation;
  String orderCreation;
  String ordersFetched;

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

  Future<List<Product>> getProducts(String category) async {
    List<Product> products = [];
    final response = await http.get(
      Uri.https(BASE_URL, USER_GET_PRODUCTS + category),
    );
    var extract = json.decode(response.body);
    var productsJson = extract['products'];
    if (response.statusCode == 200) {
      for (Map i in productsJson) {
        products.add(Product.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t fetch data');
    }
    return products;
  }

  Future<Order> placeOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $userToken', 'Content-Type': 'application/json'};

    return await http
        .post(
      Uri.https(BASE_URL, ORDERS_URL),
      body: jsonEncode(order.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        orderCreation = 'Order Placed Successfully!';
      } else {
        orderCreation = json.decode(response.body)['error'];
      }
      return Order.fromJson(json.decode(response.body));
    });
  }

  Future<List<PrevOrders>> getPreviousOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $userToken'};

    List<PrevOrders> orders = [];

    final response = await http.get(Uri.https(BASE_URL, ORDERS_URL), headers: headers);

    var extract = json.decode(response.body);
    var ordersJson = extract['prevOrders'];
    if (response.statusCode == 200) {
      ordersFetched = 'Orders Fetched Successfully!';
      for (Map i in ordersJson) {
        orders.add(PrevOrders.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t fetch orders');
    }

    return orders;
  }
}
