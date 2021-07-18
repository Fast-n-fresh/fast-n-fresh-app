import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/consts/constants.dart';
import 'package:natures_delicacies/models/cart.dart';
import 'package:natures_delicacies/models/order.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/network/product_utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Razorpay razorpay;
  FToast fToast;

  ProductUtils productUtils = new ProductUtils();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    fToast = FToast();
    fToast.init(context);
  }

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
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      'key': RAZORPAY_API_KEY,
      'amount': Provider.of<Cart>(context, listen: false).getTotalPrice * 100,
      'name': 'Fast n\' fresh',
      'description': 'Payment for grocery order',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm', 'phonepe', 'amazonpay']
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void placeOrder() async {
    List<Product> productList = Provider.of<Cart>(context, listen: false).getProducts();
    List<Products> products = [];

    for (int i = 0; i < productList.length; i += 1) {
      products.add(new Products(productId: productList[i].id, quantity: productList[i].quantity));
      print('$i: ${productList[i].id}, ${productList[i].quantity}');
    }

    Order order = new Order(products: products);
    await productUtils.placeOrder(order).then((value) async {
      if (productUtils.orderCreation == 'Order Created Successfully!') {
        _showToast('Payment Successful, Order Created Successfully!');
      } else {
        _showToast('Error placing order, ${productUtils.orderCreation}');
      }
    });
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    placeOrder();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    _showToast('Payment Failed, Error: ' + response.message);
    print(response.message);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    _showToast('External Wallet: ' + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: UniqueKey(),
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, 1),
          child: Consumer<Cart>(
            builder: (context, cart, child) => (cart.getLength() == 0)
                ? EmptyCartWidget()
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'My Cart',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: Provider.of<Cart>(context, listen: false).getLength(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      offset: Offset(1, 4),
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: Image.network(
                                          Provider.of<Cart>(context, listen: false)
                                              .getProducts()[index]
                                              .imageUrl,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(
                                                Provider.of<Cart>(context, listen: false)
                                                    .getProducts()[index]
                                                    .name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 24,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(
                                                "\u20B9 " +
                                                    Provider.of<Cart>(context, listen: false)
                                                        .getProducts()[index]
                                                        .price
                                                        .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(
                                                "per " +
                                                    Provider.of<Cart>(context, listen: false)
                                                        .getProducts()[index]
                                                        .unit,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).accentColor,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Provider.of<Cart>(context, listen: false)
                                                              .decrementQuantity(index);
                                                        },
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Consumer<Cart>(
                                                          builder: (context, cart, child) => Text(
                                                            '${cart.getProducts()[index].quantity}',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.normal,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Provider.of<Cart>(context, listen: false)
                                                              .incrementQuantity(index);
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                        onPressed: () {
                                          Provider.of<Cart>(context, listen: false).remove(index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    'Total: ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Consumer<Cart>(
                                  builder: (context, cart, child) => Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "\u20B9 " + cart.getTotalPrice.toString(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              width: screenWidth,
                              height: 60,
                              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              child: TextButton(
                                onPressed: () {
                                  openCheckout();
                                },
                                child: Text(
                                  'Checkout',
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.25,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          color: Colors.black.withOpacity(0.3),
          size: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Looks like you haven\'t added anything to the cart yet.',
            style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
