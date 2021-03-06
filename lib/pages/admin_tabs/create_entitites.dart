import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/delivery_boy_register.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/product_category.dart';
import 'package:natures_delicacies/network/account_utils.dart';
import 'package:natures_delicacies/network/order_utils.dart';

class CreateEntities extends StatefulWidget {
  const CreateEntities({Key key}) : super(key: key);

  @override
  _CreateEntitiesState createState() => _CreateEntitiesState();
}

class _CreateEntitiesState extends State<CreateEntities> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryImgController = TextEditingController();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productImgController = TextEditingController();
  TextEditingController productUnitController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();

  TextEditingController deliveryBoyNameController = TextEditingController();
  TextEditingController deliveryBoyEmailController = TextEditingController();
  TextEditingController deliveryBoyPhoneController = TextEditingController();
  TextEditingController deliveryBoyPasswordController = TextEditingController();

  bool categoryNameValidate = false;
  bool categoryImgValidate = false;

  bool productNameValidate = false;
  bool productImgValidate = false;
  bool productUnitValidate = false;
  bool productPriceValidate = false;
  bool productDescValidate = false;
  bool productCategoryValidate = false;

  bool deliveryBoyNameValidate = false;
  bool deliveryBoyEmailValidate = false;
  bool deliveryBoyPhoneValidate = false;
  bool deliveryBoyPasswordValidate = false;

  bool isCategoryLoading = false;
  bool isProductLoading = false;
  bool isDeliveryBoyLoading = false;

  OrderUtils orderUtils = new OrderUtils();
  AccountUtils accountUtils = new AccountUtils();

  FToast fToast;

  _showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[700],
      ),
      child: Text(
        message,
        style: GoogleFonts.raleway(color: Colors.white),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    categoryNameController.dispose();
    categoryImgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenWidth * 0.050,
            left: screenWidth * 0.050,
            top: screenHeight * 0.040,
            bottom: screenHeight * 0.00,
          ),
          child: Column(
            children: [
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New Items',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create new category',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            context,
                            'Category Name',
                            Icons.category,
                            categoryNameController,
                            categoryNameValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(
                            context,
                            'Category Image URL',
                            Icons.image,
                            categoryImgController,
                            categoryImgValidate,
                            TextInputAction.done,
                            screenWidth),
                        Container(
                          width: screenWidth,
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: isCategoryLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    String categoryName;
                                    String categoryUrl;

                                    setState(() {
                                      isCategoryLoading = true;
                                      categoryName = categoryNameController.text;
                                      categoryUrl = categoryImgController.text;

                                      categoryName.isEmpty
                                          ? categoryNameValidate = true
                                          : categoryNameValidate = false;
                                      categoryUrl.isEmpty
                                          ? categoryImgValidate = true
                                          : categoryImgValidate = false;
                                    });

                                    if (categoryName.isEmpty || categoryUrl.isEmpty) {
                                      setState(() {
                                        isCategoryLoading = false;
                                      });
                                    } else {
                                      ProductCategory category = ProductCategory(
                                        name: categoryName,
                                        imageUrl: categoryUrl,
                                      );
                                      await orderUtils.createCategory(category).then((value) async {
                                        setState(() {
                                          isCategoryLoading = false;
                                        });
                                        if (orderUtils.categoryCreation ==
                                            'Category Created Successfully!') {
                                          setState(() {
                                            categoryNameController.text = "";
                                            categoryImgController.text = "";
                                          });
                                          _showToast("Category Created Successfully!");
                                        } else {
                                          _showToast(orderUtils.categoryCreation);
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Create',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Create new product',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            context,
                            'Product Name',
                            Icons.shopping_cart,
                            productNameController,
                            productNameValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(
                            context,
                            'Product Image URL',
                            Icons.image,
                            productImgController,
                            productImgValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(
                            context,
                            'Product Units',
                            Icons.looks_one,
                            productUnitController,
                            productUnitValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(context, 'Product Price', Icons.sell, productPriceController,
                            productPriceValidate, TextInputAction.next, screenWidth),
                        buildTextField(
                            context,
                            'Product Description',
                            Icons.text_snippet_outlined,
                            productDescController,
                            productDescValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(
                            context,
                            'Product Category',
                            Icons.category,
                            productCategoryController,
                            productCategoryValidate,
                            TextInputAction.done,
                            screenWidth),
                        Container(
                          width: screenWidth,
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: isProductLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    String productName;
                                    String productUrl;
                                    String productUnit;
                                    int productPrice;
                                    String productPriceText;
                                    String productDesc;
                                    String productCategory;

                                    setState(() {
                                      isProductLoading = true;
                                      productName = productNameController.text;
                                      productUrl = productImgController.text;
                                      productUnit = productUnitController.text;
                                      productPriceText = productPriceController.text;
                                      productDesc = productDescController.text;
                                      productCategory = productCategoryController.text;
                                      if (productPriceText.isEmpty) {
                                        productPrice = 0;
                                      } else {
                                        productPrice = int.parse(productPriceText);
                                      }

                                      if (productDesc.isEmpty) {
                                        productDesc = "Description not available!";
                                        productDescController.text = "Description not available!";
                                      }

                                      productName.isEmpty
                                          ? productNameValidate = true
                                          : productNameValidate = false;
                                      productUrl.isEmpty
                                          ? productImgValidate = true
                                          : productImgValidate = false;
                                      productUnit.isEmpty
                                          ? productUnitValidate = true
                                          : productUnitValidate = false;
                                      productPriceText.isEmpty
                                          ? productPriceValidate = true
                                          : productPriceValidate = false;
                                      productCategory.isEmpty
                                          ? productCategoryValidate = true
                                          : productCategoryValidate = false;
                                    });

                                    if (productName.isEmpty ||
                                        productUrl.isEmpty ||
                                        productUnit.isEmpty ||
                                        productPriceText.isEmpty ||
                                        productCategory.isEmpty) {
                                      setState(() {
                                        isProductLoading = false;
                                      });
                                    } else {
                                      Product product = Product(
                                        name: productName,
                                        imageUrl: productUrl,
                                        unit: productUnit,
                                        price: productPrice,
                                        category: productCategory,
                                        description: productDesc,
                                      );
                                      await orderUtils.createProduct(product).then((value) async {
                                        setState(() {
                                          isProductLoading = false;
                                        });
                                        if (orderUtils.productCreation ==
                                            'Product Created Successfully!') {
                                          _showToast("Product Created Successfully!");
                                          setState(() {
                                            productNameController.text = "";
                                            productImgController.text = "";
                                            productUnitController.text = "";
                                            productDescController.text = "";
                                            productCategoryController.text = "";
                                            productPriceController.text = "";
                                          });
                                        } else {
                                          _showToast(orderUtils.productCreation);
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Create',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register Delivery Boy',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(context, 'Name', Icons.person, deliveryBoyNameController,
                            deliveryBoyNameValidate, TextInputAction.next, screenWidth),
                        buildTextField(context, 'Email', Icons.email, deliveryBoyEmailController,
                            deliveryBoyEmailValidate, TextInputAction.next, screenWidth),
                        buildTextField(
                            context,
                            'Phone Number',
                            Icons.phone,
                            deliveryBoyPhoneController,
                            deliveryBoyPhoneValidate,
                            TextInputAction.next,
                            screenWidth),
                        buildTextField(
                            context,
                            'Password',
                            Icons.lock,
                            deliveryBoyPasswordController,
                            deliveryBoyPasswordValidate,
                            TextInputAction.done,
                            screenWidth),
                        Container(
                          width: screenWidth,
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: isDeliveryBoyLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    String deliveryBoyName;
                                    String deliveryBoyEmail;
                                    String deliveryBoyPhone;
                                    String deliveryBoyPassword;

                                    setState(() {
                                      isDeliveryBoyLoading = true;
                                      deliveryBoyName = deliveryBoyNameController.text;
                                      deliveryBoyEmail = deliveryBoyEmailController.text;
                                      deliveryBoyPhone = deliveryBoyPhoneController.text;
                                      deliveryBoyPassword = deliveryBoyPasswordController.text;

                                      deliveryBoyName.isEmpty
                                          ? deliveryBoyNameValidate = true
                                          : deliveryBoyNameValidate = false;
                                      deliveryBoyEmail.isEmpty
                                          ? deliveryBoyEmailValidate = true
                                          : deliveryBoyEmailValidate = false;
                                      deliveryBoyPhone.isEmpty
                                          ? deliveryBoyPhoneValidate = true
                                          : deliveryBoyPhoneValidate = false;
                                      deliveryBoyPassword.isEmpty
                                          ? deliveryBoyPasswordValidate = true
                                          : deliveryBoyPasswordValidate = false;
                                    });

                                    if (deliveryBoyName.isEmpty ||
                                        deliveryBoyEmail.isEmpty ||
                                        deliveryBoyPhone.isEmpty ||
                                        deliveryBoyPassword.isEmpty) {
                                      setState(() {
                                        isDeliveryBoyLoading = false;
                                      });
                                    } else {
                                      DeliveryBoyRegister deliveryBoy = DeliveryBoyRegister(
                                        name: deliveryBoyName,
                                        email: deliveryBoyEmail,
                                        phoneNumber: deliveryBoyPhone,
                                        password: deliveryBoyPassword,
                                      );

                                      await accountUtils
                                          .registerDeliveryBoy(deliveryBoy)
                                          .then((value) async {
                                        setState(() {
                                          isDeliveryBoyLoading = false;
                                        });
                                        if (accountUtils.signUpError == 'no error') {
                                          _showToast("Delivery Boy Registered Successfully!");
                                          setState(() {
                                            deliveryBoyNameController.text = "";
                                            deliveryBoyEmailController.text = "";
                                            deliveryBoyPhoneController.text = "";
                                            deliveryBoyPasswordController.text = "";
                                          });
                                        } else {
                                          _showToast(accountUtils.signUpError);
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Create',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container buildTextField(
  BuildContext context,
  String hint,
  IconData icon,
  TextEditingController controller,
  bool validate,
  TextInputAction action,
  double screenWidth,
) {
  return Container(
    width: screenWidth,
    height: 60,
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Expanded(
          child: TextField(
            textInputAction: action,
            style: GoogleFonts.montserrat(),
            controller: controller,
            decoration: InputDecoration(
              errorText: validate ? 'Field can\'t be empty' : null,
              errorStyle: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.error,
              ),
              border: InputBorder.none,
              hintText: '$hint',
              hintStyle: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
