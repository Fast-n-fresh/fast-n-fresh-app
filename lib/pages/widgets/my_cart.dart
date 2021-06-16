import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart_model.dart';
import 'package:natures_delicacies/pages/checkout.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: UniqueKey(),
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, 1),
          child: Consumer<CartModel>(
            builder: (context, cart, child) => (cart.getLength() == 0)
                ? EmptyCartWidget()
                : NonEmptyCartWidget(screenWidth: screenWidth),
          ),
        ),
      ),
    );
  }
}

class NonEmptyCartWidget extends StatelessWidget {
  const NonEmptyCartWidget({
    Key key,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              itemCount: Provider.of<CartModel>(context, listen: false).getLength(),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Image.asset(
                          Provider.of<CartModel>(context, listen: false).getItems()[index].imgUrl,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                Provider.of<CartModel>(context, listen: false)
                                    .getItems()[index]
                                    .name,
                                style: GoogleFonts.montserrat(
                                    fontSize: 24, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "\u20B9 " +
                                    Provider.of<CartModel>(context, listen: false)
                                        .getItems()[index]
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
                                    Provider.of<CartModel>(context, listen: false)
                                        .getItems()[index]
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
                                          Provider.of<CartModel>(context, listen: false)
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
                                        child: Consumer<CartModel>(
                                          builder: (context, cart, child) => Text(
                                            '${cart.getItems()[index].quantity}',
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
                                          Provider.of<CartModel>(context, listen: false)
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
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false).remove(index);
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
              flex: 1,
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
                  Consumer<CartModel>(
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
              flex: 3,
              child: Container(
                width: screenWidth,
                height: 60,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Checkout(),
                        transitionDuration: Duration(milliseconds: 1000),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                          return SlideTransition(
                            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                                .animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
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
