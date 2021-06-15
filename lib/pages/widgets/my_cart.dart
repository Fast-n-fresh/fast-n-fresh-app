import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart_item.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: UniqueKey(),
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, 1),
          child: cartItems.length == 0
              ? Column(
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
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
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
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    child: Image.asset(
                                      cartItems[index].imgUrl,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            cartItems[index].name,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            "\u20B9 " +
                                                cartItems[index]
                                                    .price
                                                    .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
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
                                            color:
                                                Theme.of(context).accentColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (cartItems[index]
                                                              .quantity >
                                                          0) {
                                                        setState(() {
                                                          cartItems[index]
                                                              .quantity--;
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      '${cartItems[index].quantity}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        cartItems[index]
                                                            .quantity++;
                                                      });
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
                                        setState(() {
                                          cartItems.removeAt(index);
                                        });
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
                  ],
                ),
        ),
      ),
    );
  }
}

List<CartItem> cartItems = [
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
  CartItem(
      name: "Banana",
      price: 20.0,
      quantity: 1,
      imgUrl: './lib/images/banana.png'),
];
