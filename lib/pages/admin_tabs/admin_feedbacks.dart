import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:natures_delicacies/models/feedback_list.dart';
import 'package:natures_delicacies/network/order_utils.dart';

class AdminFeedbacks extends StatefulWidget {
  const AdminFeedbacks({Key key}) : super(key: key);

  @override
  _AdminFeedbacksState createState() => _AdminFeedbacksState();
}

class _AdminFeedbacksState extends State<AdminFeedbacks> {
  OrderUtils orderUtils = new OrderUtils();

  List<Feedbacks> feedbacks = [];

  Future getFeedbacks() async {
    await orderUtils.getAdminFeedbacks().then((value) {
      feedbacks = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: FutureBuilder(
          future: getFeedbacks(),
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
                print('fetched feedbacks');
            }
            return feedbacks.isEmpty
                ? EmptyFeedbacks()
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
                          'Feedbacks',
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
                            itemCount: feedbacks.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   PageRouteBuilder(
                                //     pageBuilder: (context, animation, secondaryAnimation) =>
                                //         PendingOrderDetails(),
                                //     transitionDuration: Duration(milliseconds: 1000),
                                //     transitionsBuilder:
                                //         (context, animation, secondaryAnimation, child) {
                                //       animation = CurvedAnimation(
                                //           parent: animation, curve: Curves.easeInOut);
                                //       return SlideTransition(
                                //         position:
                                //             Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                                //                 .animate(animation),
                                //         child: child,
                                //       );
                                //     },
                                //   ),
                                // );
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
                                                .parse(feedbacks[index].timeStamp),
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
                                          'Rating: ${feedbacks[index].rating}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Delivery Boy ID: ${feedbacks[index].deliveryBoy}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'User ID: ${feedbacks[index].user}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Message: ${feedbacks[index].message}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
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
    );
  }
}

class EmptyFeedbacks extends StatelessWidget {
  const EmptyFeedbacks({
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
            Icons.question_answer,
            color: Colors.black.withOpacity(0.3),
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Looks like there are no feedbacks.',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
