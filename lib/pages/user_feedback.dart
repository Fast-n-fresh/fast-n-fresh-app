import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natures_delicacies/network/order_utils.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({Key key}) : super(key: key);

  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  double _rating = 0;
  TextEditingController _messageController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  OrderUtils orderUtils = new OrderUtils();
  bool _isLoading = false;
  bool validName = true;
  bool validMessage = true;

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _nameController.dispose();
  }

  FToast fToast;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feedbacks',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Rating: ${_rating.toStringAsFixed(1)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Slider(
                          min: 0,
                          max: 5,
                          label: _rating.toString(),
                          value: _rating,
                          onChanged: (double value) {
                            setState(() {
                              _rating = value;
                            });
                          },
                        ),
                        Container(
                          width: screenWidth,
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.start,
                            controller: _nameController,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                            ),
                            decoration: InputDecoration(
                              errorText: validName ? null : 'Field can\'t be empty',
                              errorStyle: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.error,
                              ),
                              hintText: 'Delivery Boy Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.start,
                            controller: _messageController,
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                            ),
                            decoration: InputDecoration(
                              errorText: validMessage ? null : 'Field can\'t be empty',
                              errorStyle: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.error,
                              ),
                              hintText: 'Message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    if (_messageController.text.isEmpty ||
                                        _nameController.text.isEmpty) {
                                      setState(() {
                                        _isLoading = false;

                                        validMessage =
                                            _messageController.text.isEmpty ? false : true;
                                        validName = _nameController.text.isEmpty ? false : true;
                                      });
                                    } else {
                                      await orderUtils
                                          .sendFeedback(
                                        _messageController.text,
                                        double.parse(_rating.toStringAsFixed(1)),
                                        _nameController.text,
                                      )
                                          .then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        _showToast(value);
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
