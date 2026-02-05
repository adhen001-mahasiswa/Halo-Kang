import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';

// Screens
import '../entry/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/history_screen.dart';

// Auth
import '../auth/login_page.dart';
import '../auth/register_page.dart';
import '../auth/role_selection_page.dart';

// Mitra
import '../mitra/mitra_home_page.dart';
import '../mitra/incoming_order_page.dart';
import '../mitra/mitra_register_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirebaseService>(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Halo Tukang',
        theme: ThemeData(
          primaryColor: const Color(0xFF5D8BF4),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5D8BF4),
            secondary: const Color(0xFFFFB4B4),
          ),
          scaffoldBackgroundColor: const Color(0xFFFDFDFE),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 1,
          ),
        ),

        // splash → login → role → home
        initialRoute: '/splash',

        // ROUTES TANPA PARAMETER
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),

          // USER
          '/': (_) => const HomeScreen(),
          '/history': (_) => HistoryScreen(),

          // MITRA
          '/mitra-home': (_) => const MitraHomePage(),
          '/mitra-incoming': (_) => const IncomingOrderPage(),

          '/role': (_) => const RoleSelectionPage(),
          '/mitra-register': (_) => const MitraRegisterPage(),
        },

        // ROUTES DENGAN PARAMETER
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
          }
          return null;
        },
      ),
    );
  }
}
