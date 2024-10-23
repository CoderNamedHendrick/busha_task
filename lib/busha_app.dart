import 'shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routing/routing.dart';

class BushaApp extends StatefulWidget {
  const BushaApp({super.key});

  @override
  State<BushaApp> createState() => _BushaAppState();
}

class _BushaAppState extends State<BushaApp> {
  @override
  void initState() {
    super.initState();

    Future.microtask(SvgAssets.preloadSvgs);
  }

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
          textTheme: GoogleFonts.interTextTheme().copyWith(
            titleMedium: TextStyle(fontSize: 20),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xff12a633),
              minimumSize: Size(double.infinity, 48),
              textStyle: TextStyle(fontSize: 16).semi,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          useMaterial3: true,
        ),
        navigatorKey: BushaRouter.routeKey,
        initialRoute: BushaRouter.initialRoute,
        onGenerateRoute: BushaRouter.instance.routeGenerator,
      ),
    );
  }
}
