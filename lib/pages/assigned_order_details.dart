import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/assigned_orders_list.dart';

class AssignedOrderDetails extends StatefulWidget {
  final List<Products> products;

  const AssignedOrderDetails({Key key, @required this.products}) : super(key: key);

  @override
  _AssignedOrderDetailsState createState() => _AssignedOrderDetailsState();
}

class _AssignedOrderDetailsState extends State<AssignedOrderDetails> {
  int getTotalCost() {
    int total = 0;
    for (int i = 0; i < widget.products.length; i++) {
      total += (widget.products[i].quantity * widget.products[i].product.price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: Text(
                'Order Details',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: widget.products.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  key: UniqueKey(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.network(
                                widget.products[index].product.imageUrl,
                                height: 120,
                                width: 120,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.products[index].product.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.products[index].quantity.toString() +
                                          ' x ' +
                                          "\u20B9 " +
                                          widget.products[index].product.price.toString() +
                                          ' per ' +
                                          widget.products[index].product.unit +
                                          ' \n= ' +
                                          "\u20B9 " +
                                          (widget.products[index].product.price *
                                                  widget.products[index].quantity)
                                              .toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Cost: \u20B9 ' + getTotalCost().toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
