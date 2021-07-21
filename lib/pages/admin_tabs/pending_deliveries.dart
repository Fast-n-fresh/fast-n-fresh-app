import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/delivery_status_list.dart';
import 'package:natures_delicacies/network/order_utils.dart';

class PendingDeliveries extends StatefulWidget {
  const PendingDeliveries({Key key}) : super(key: key);

  @override
  _PendingDeliveriesState createState() => _PendingDeliveriesState();
}

class _PendingDeliveriesState extends State<PendingDeliveries> {
  OrderUtils orderUtils = new OrderUtils();

  List<PendingDeliveryStatus> deliveries = [];

  Future getDeliveries() async {
    await orderUtils.getDeliveryStatus().then((value) {
      deliveries = value;
    });
  }

  List<Widget> getPendingOrders(int index) {
    List<Widget> items = [];
    for (int i = 0; i < deliveries[index].pendingOrders.length; i++) {
      items.add(
        Text(
          'Order ID - ${deliveries[index].pendingOrders[i]}',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    if (items.isEmpty) {
      items.add(
        Text(
          'All orders have been delivered',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: FutureBuilder(
          future: getDeliveries(),
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
                print('fetched orders to be delivered');
            }
            return deliveries.isEmpty
                ? EmptyOrders()
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
                          'Delivery Status',
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
                            itemCount: deliveries.length,
                            itemBuilder: (context, index) => Padding(
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
                                        '${deliveries[index].deliveryBoy}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Pending Orders:',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: getPendingOrders(index),
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
                        height: 20,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({
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
            Icons.delivery_dining,
            color: Colors.black.withOpacity(0.3),
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Looks like there is no order left to be delivered.',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
