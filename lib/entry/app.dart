import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/history_screen.dart';
import 'splash_screen.dart';
import '../auth/login_page.dart';
import '../auth/register_page.dart';
import '../auth/role_selection_page.dart';
import '../mitra/mitra_home_page.dart';
import '../mitra/incoming_order_page.dart';
import '../mitra/order_detail_page.dart';

// Services
import '../services/mock_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MockService>(create: (_) => MockService()),
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
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 14.0),
          ),
        ),

        initialRoute: '/splash',

        // ROUTES TANPA PARAMETER
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/role': (_) => const RoleSelectionPage(),
          '/mitra-home': (_) => const MitraHomePage(),
          '/history': (_) => HistoryScreen(),
          '/mitra-incoming': (_) => const IncomingOrderPage(),
          '/': (_) => HomeScreen(),
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

            case '/checkout':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => CheckoutScreen(tukang: args['tukang']),
              );
          }
          return null;
        },
      ),
    );
  }
}
