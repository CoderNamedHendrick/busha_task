import 'package:busha_interview/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routing/routing.dart';

class BushaApp extends StatelessWidget {
  const BushaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(12),
            fillColor: Color(0xffefefef),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff5a5a5a),
            ).inter,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.32),
            ).inter,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff12a633),
            surface: Colors.white,
            onSurface: Colors.black,
            onSurfaceVariant: Color(0xff9ba0a5),
            error: Color(0xffc00f00),
          ),
          textTheme: GoogleFonts.interTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: BushaRouter.initialRoute,
        onGenerateRoute: BushaRouter.instance.routeGenerator,
      ),
    );
  }
}
