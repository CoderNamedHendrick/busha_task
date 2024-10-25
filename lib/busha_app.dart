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
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Busha Interview',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
            fillColor: const Color(0xffefefef),
            labelStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff5a5a5a),
              ),
            ),
            hintStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.32),
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff12a633),
            primary: const Color(0xff12a633),
            surface: Colors.white,
            onSurface: Colors.black,
            onSurfaceVariant: const Color(0xff9ba0a5),
            onInverseSurface: const Color(0xfff2f3f7),
            surfaceTint: const Color(0xffb7b7b7),
            error: const Color(0xffc00f00),
          ),
          textTheme: GoogleFonts.interTextTheme().copyWith(
            displayMedium: const TextStyle(fontSize: 32),
            titleMedium: const TextStyle(fontSize: 20),
            titleSmall: const TextStyle(fontSize: 18),
            bodyLarge: const TextStyle(fontSize: 16),
            bodyMedium: const TextStyle(fontSize: 14),
            bodySmall: const TextStyle(fontSize: 12),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff12a633),
              minimumSize: const Size(double.infinity, 48),
              textStyle: const TextStyle(fontSize: 16).semi,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xff12a633),
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
