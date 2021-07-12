import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black.withOpacity(0.3),
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Looks like you haven\'t ordered anything yet.',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
