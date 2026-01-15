import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/tukang_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/history_screen.dart';

// Services
import 'services/mock_service.dart';

void main() {
  runApp(const HaloTukangApp());
}

class HaloTukangApp extends StatelessWidget {
  const HaloTukangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MockService>(create: (_) => MockService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Halo Tukang',

        // ===============================
        // THEME – Friendly & Soft Colors
        // ===============================
        theme: ThemeData(
          primaryColor: const Color(0xFF5D8BF4), // Biru Pastel
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5D8BF4),
            secondary: const Color(0xFFFFB4B4), // Pink Pastel (Cute)
          ),
          scaffoldBackgroundColor: const Color(0xFFFDFDFE),

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 1,
          ),

          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 14.0),
          ),
        ),

        // ===============================
        // ROUTING
        // ===============================
        initialRoute: '/',
        routes: {
          '/': (_) => HomeScreen(),
          '/list': (_) => TukangListScreen(),
          '/history': (_) => HistoryScreen(),
        },

        // ===============================
        // ROUTES DENGAN ARGUMENTS
        // ===============================
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/profile':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => ProfileScreen(tukang: args['tukang']),
              );

            case '/booking':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => BookingScreen(tukang: args['tukang']),
              );

            case '/checkout':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => CheckoutScreen(order: args['order']),
              );
          }
          return null; // Jika route tidak ditemukan
        },
      ),
    );
  }
}
