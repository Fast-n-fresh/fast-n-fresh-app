import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart.dart';
import 'package:natures_delicacies/models/product.dart';
import 'package:natures_delicacies/models/user_page.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final int index;
  final List<Product> products;

  const ItemDetails({Key key, @required this.index, @required this.products}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Back',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'image ' + widget.products[widget.index].name,
                        child: Image.network(
                          widget.products[widget.index].imageUrl,
                          height: 300,
                          width: 300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.products[widget.index].name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\u20B9 ' + widget.products[widget.index].price.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'per ' + widget.products[widget.index].unit,
                      style: GoogleFonts.montserrat(
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 0) {
                                  count--;
                                }
                              });
                            },
                            icon: Icon(Icons.remove),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 30,
                          child: Center(
                            child: Text(
                              count.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: Icon(Icons.add),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          bool flag = false;
                          if (count != 0) {
                            for (int i = 0;
                                i < Provider.of<Cart>(context, listen: false).getLength();
                                i++) {
                              if (widget.products[widget.index].name ==
                                  Provider.of<Cart>(context, listen: false).getProducts()[i].name) {
                                flag = true;
                                Provider.of<Cart>(context, listen: false)
                                    .getProducts()[i]
                                    .quantity += count;
                                break;
                              }
                            }
                            if (!flag) {
                              Provider.of<Cart>(context, listen: false)
                                  .add(widget.products[widget.index]);
                              if (count != 1) {
                                for (int i = 0;
                                    i < Provider.of<Cart>(context, listen: false).getLength();
                                    i++) {
                                  if (widget.products[widget.index].name ==
                                      Provider.of<Cart>(context, listen: false)
                                          .getProducts()[i]
                                          .name) {
                                    Provider.of<Cart>(context, listen: false)
                                        .getProducts()[i]
                                        .quantity += (count - 1);
                                  }
                                }
                              }
                            }
                          }
                          Navigator.pop(context);
                          Provider.of<UserPage>(context, listen: false).setCurrentPage(2);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          child: Container(
                            width: screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: Center(
                              child: Text(
                                'Add to Cart',
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.25,
                                ),
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
          ],
        ),
      ),
    );
  }
}
