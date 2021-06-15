import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natures_delicacies/models/cart_model.dart';
import 'package:natures_delicacies/models/page_model.dart';
import 'package:natures_delicacies/models/user_profile_model.dart';
import 'package:natures_delicacies/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorSchemeLight = new ColorScheme(
      primary: Colors.red,
      primaryVariant: Colors.redAccent,
      secondary: Color(0xFF40284A),
      secondaryVariant: Color(0xFF6C5176),
      surface: Color(0xFFFFFFFF),
      background: Colors.white,
      error: Colors.deepOrangeAccent,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.grey,
      onBackground: Colors.grey[700],
      onError: Colors.white,
      brightness: Brightness.light,
    );

    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('licenses/OFL_Montserrat');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('licenses/OFL_Poppins');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('licenses/OFL_Raleway');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => PageModel()),
        ChangeNotifierProvider(create: (context) => UserProfileModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nature\'s Delicacies',
        theme: ThemeData(
          colorScheme: colorSchemeLight,
          backgroundColor: colorSchemeLight.background,
          primarySwatch: colorSchemeLight.primary,
          accentColor: colorSchemeLight.primaryVariant,
          buttonColor: colorSchemeLight.secondary,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
