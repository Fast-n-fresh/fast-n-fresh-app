import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/delivery_boys.dart';
import 'package:natures_delicacies/models/feedback.dart';
import 'package:natures_delicacies/models/order.dart';
import 'package:natures_delicacies/models/pending_orders.dart';
import 'package:natures_delicacies/models/previous_orders.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/product_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderUtils {
  String categoryCreation;
  String productCreation;
  String orderCreation;
  String ordersFetched;
  String fetchDeliveryBoys;
  String fetchPendingOrders;
  String fetchFeedbacks;

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
      Uri.https(BASE_URL, USER_GET_CATEGORIES_URL),
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
      Uri.https(BASE_URL, USER_GET_PRODUCTS_URL + category),
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
      Uri.https(BASE_URL, USER_ORDERS_URL),
      body: jsonEncode(order.toJson()),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        orderCreation = 'Order Created Successfully!';
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

    final response = await http.get(Uri.https(BASE_URL, USER_ORDERS_URL), headers: headers);

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

  Future<List<DeliveryBoy>> getDeliveryBoys() async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $adminToken'};

    List<DeliveryBoy> deliveryBoys = [];

    final response = await http.get(Uri.https(BASE_URL, GET_DELIVERY_BOYS_URL), headers: headers);

    var extract = json.decode(response.body);
    var deliveryBoysJson = extract['deliveryBoyList'];
    if (response.statusCode == 200) {
      fetchDeliveryBoys = 'Delivery Boys Fetched Successfully!';
      for (Map i in deliveryBoysJson) {
        deliveryBoys.add(DeliveryBoy.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t get delivery boys');
    }
    return deliveryBoys;
  }

  Future assignOrder(String orderId, String deliveryBoyName) async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode(<String, String>{
      "orderId": orderId,
      "deliveryBoyName": deliveryBoyName,
    });
    String toastMessage;

    final response = await http.patch(
      Uri.https(BASE_URL, ADMIN_ORDERS_URL),
      headers: headers,
      body: body,
    );

    var extract = json.decode(response.body);
    if (response.statusCode == 200) {
      toastMessage = extract['message'];
    } else {
      toastMessage = extract['e'];
    }
    return toastMessage;
  }

  Future sendFeedback(String message, double rating, String deliveryBoyName) async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      "message": message,
      "rating": rating,
      "deliveryBoyName": deliveryBoyName,
    });
    String toastMessage;

    final response = await http.post(
      Uri.https(BASE_URL, USER_FEEDBACKS_URL),
      headers: headers,
      body: body,
    );

    var extract = json.decode(response.body);
    if (response.statusCode == 200) {
      toastMessage = extract['message'];
    } else {
      toastMessage = extract['e'];
    }
    return toastMessage;
  }

  Future<List<PendingOrders>> getPendingOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $adminToken'};

    List<PendingOrders> pendingOrders = [];

    final response = await http.get(Uri.https(BASE_URL, ADMIN_ORDERS_URL), headers: headers);

    var extract = json.decode(response.body);
    var pendingOrdersJson = extract['pendingOrders'];
    if (response.statusCode == 200) {
      fetchPendingOrders = 'Orders Fetched Successfully!';
      for (Map i in pendingOrdersJson) {
        pendingOrders.add(PendingOrders.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t get pending orders');
    }
    return pendingOrders;
  }

  Future<List<Feedbacks>> getAdminFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();
    String adminToken = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $adminToken'};

    List<Feedbacks> feedbacks = [];

    final response = await http.get(Uri.https(BASE_URL, ADMIN_FEEDBACKS_URL), headers: headers);

    var extract = json.decode(response.body);
    var feedbacksJson = extract['feedbacks'];
    if (response.statusCode == 200) {
      fetchFeedbacks = 'Feedbacks Fetched Successfully!';
      for (Map i in feedbacksJson) {
        feedbacks.add(Feedbacks.fromJson(i));
      }
    } else {
      throw new Exception('Couldn\'t get feedbacks');
    }
    return feedbacks;
  }
}
