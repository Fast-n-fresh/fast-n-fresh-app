import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:natures_delicacies/models/assigned_orders_list.dart';
import 'package:natures_delicacies/network/order_utils.dart';
import 'package:natures_delicacies/pages/assigned_order_details.dart';

class AssignedOrders extends StatefulWidget {
  const AssignedOrders({Key key}) : super(key: key);

  @override
  _AssignedOrdersState createState() => _AssignedOrdersState();
}

class _AssignedOrdersState extends State<AssignedOrders> {
  OrderUtils orderUtils = new OrderUtils();

  List<Orders> assignedOrders = [];

  Future getAssignedOrders() async {
    await orderUtils.getAssignedOrders().then((value) {
      assignedOrders = value;
    });
  }

  int getTotalCost(int index) {
    int total = 0;

    for (int i = 0; i < assignedOrders[index].products.length; i++) {
      total += (assignedOrders[index].products[i].quantity *
          assignedOrders[index].products[i].product.price);
    }
    return total;
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
            bottom: 20,
          ),
          child: FutureBuilder(
            future: getAssignedOrders(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Loading...',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                case ConnectionState.done:
                  print('fetched orders');
              }
              return assignedOrders.isEmpty
                  ? EmptyAssignedOrders()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.050,
                            right: screenWidth * 0.050,
                            top: screenHeight * 0.030,
                          ),
                          child: Text(
                            'Assigned Orders',
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: assignedOrders.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          AssignedOrderDetails(
                                              products: assignedOrders[index].products),
                                      transitionDuration: Duration(milliseconds: 1000),
                                      transitionsBuilder:
                                          (context, animation, secondaryAnimation, child) {
                                        animation = CurvedAnimation(
                                            parent: animation, curve: Curves.easeInOut);
                                        return SlideTransition(
                                          position:
                                              Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                                                  .animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.050,
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.050,
                                        vertical: screenHeight * 0.030,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('EEE, MMMM dd, yyyy, hh:mm a').format(
                                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                                  .parse(assignedOrders[index].timeStamp)
                                                  .add(
                                                    Duration(
                                                      hours: 5,
                                                      minutes: 30,
                                                    ),
                                                  ),
                                            ),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Total Cost: \u20B9 ' + getTotalCost(index).toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Status: ${assignedOrders[index].status}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Order ID: ${assignedOrders[index].id}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey[700],
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
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class EmptyAssignedOrders extends StatelessWidget {
  const EmptyAssignedOrders({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_ind,
            color: Colors.black.withOpacity(0.3),
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Looks like you don\'t have any assigned orders.',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
