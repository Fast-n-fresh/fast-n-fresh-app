import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/models/admin_page.dart';
import 'package:natures_delicacies/models/delivery_boys.dart';
import 'package:natures_delicacies/models/pending_orders.dart';
import 'package:natures_delicacies/network/order_utils.dart';
import 'package:provider/provider.dart';

class PendingOrderDetails extends StatefulWidget {
  final List<Products> products;
  final String orderId;

  const PendingOrderDetails({Key key, @required this.products, @required this.orderId})
      : super(key: key);

  @override
  _PendingOrderDetailsState createState() => _PendingOrderDetailsState();
}

class _PendingOrderDetailsState extends State<PendingOrderDetails> {
  String _chosenDeliveryBoy;
  OrderUtils orderUtils = new OrderUtils();
  List<DeliveryBoy> deliveryBoys = [];
  List<String> dropdownOptions = [];

  final AsyncMemoizer _deliveryBoyMemoizer = AsyncMemoizer();

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future getDeliveryBoys() async {
    return this._deliveryBoyMemoizer.runOnce(() async {
      await orderUtils.getDeliveryBoys().then((value) {
        deliveryBoys = value;
        for (int i = 0; i < deliveryBoys.length; i++) {
          dropdownOptions.add(deliveryBoys[i].name);
        }
      });
    });
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
            SizedBox(
              height: 10,
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
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '#${index + 1}',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product ID: \n' + widget.products[index].productId,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                'Quantity: ' + widget.products[index].quantity.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                  'Assign to: ',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FutureBuilder(
                  future: getDeliveryBoys(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        );
                      case ConnectionState.done:
                        print('fetched delivery boys');
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey[700]),
                      ),
                      child: DropdownButtonHideUnderline(
                        key: UniqueKey(),
                        child: DropdownButton<String>(
                          key: UniqueKey(),
                          hint: Text(
                            'Delivery Boy',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          menuMaxHeight: 200,
                          value: _chosenDeliveryBoy,
                          onChanged: (value) async {
                            setState(() {
                              _chosenDeliveryBoy = value;
                            });
                          },
                          items: dropdownOptions
                              .map(
                                (String value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextButton(
                onPressed: () async {
                  await orderUtils.assignOrder(widget.orderId, _chosenDeliveryBoy).then((value) {
                    if (value == 'Order Assigned to delivery Boy successfully!!') {
                      _showToast('Order Assigned Successfully!');
                      Provider.of<AdminPage>(context, listen: false).setCurrentPage(0);
                      Navigator.pop(context);
                    } else {
                      _showToast(value);
                    }
                  });
                },
                child: Text(
                  'Assign',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 1.25,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
