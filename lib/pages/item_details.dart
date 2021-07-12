import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/cart_model.dart';
import 'package:natures_delicacies/models/user_page_model.dart';
import 'package:natures_delicacies/pages/user_tabs/home_page.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final int index;

  const ItemDetails({Key key, @required this.index}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Center(
                  child: Hero(
                    tag: 'image ' + items[widget.index].name,
                    child: Image.asset(
                      items[widget.index].imgUrl,
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  items[widget.index].name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\u20B9 ' + items[widget.index].price.toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'per ' + items[widget.index].unit,
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
                            i < Provider.of<CartModel>(context, listen: false).getLength();
                            i++) {
                          if (items[widget.index] ==
                              Provider.of<CartModel>(context, listen: false).getItems()[i]) {
                            flag = true;
                            Provider.of<CartModel>(context, listen: false).getItems()[i].quantity +=
                                count;
                            break;
                          }
                        }
                        if (!flag) {
                          Provider.of<CartModel>(context, listen: false).add(items[widget.index]);
                          if (count != 1) {
                            for (int i = 0;
                                i < Provider.of<CartModel>(context, listen: false).getLength();
                                i++) {
                              if (items[widget.index] ==
                                  Provider.of<CartModel>(context, listen: false).getItems()[i]) {
                                Provider.of<CartModel>(context, listen: false)
                                    .getItems()[i]
                                    .quantity += (count - 1);
                              }
                            }
                          }
                        }
                      }
                      Navigator.pop(context);
                      Provider.of<UserPageModel>(context, listen: false).setCurrentPage(2);
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
      ),
    );
  }
}
