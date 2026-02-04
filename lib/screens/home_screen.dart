import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_service.dart';
import '../models/tukang.dart';
import '../widgets/tukang_card.dart';
import 'tukang_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MockService>(context, listen: false);

    // Ambil semua tukang
    final allTukangs = service.getTukangs();

    // Filter berdasarkan search
    final List<Tukang> filteredTukangs = allTukangs.where((t) {
      final query = searchQuery.toLowerCase();
      return t.name.toLowerCase().contains(query) ||
          t.expertise.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: const Text(
          'Halo, User 👋',
          style: TextStyle(
            color: Color(0xFF222831),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/history'),
            icon: const Icon(Icons.history, color: Color(0xFF222831)),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SEARCH BOX (REALTIME)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Cari tukang atau layanan...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // CATEGORY (tetap pindah page)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategory(context, Icons.ac_unit, 'AC'),
                      _buildCategory(
                          context, Icons.electrical_services, 'Listrik'),
                      _buildCategory(context, Icons.plumbing, 'Ledeng'),
                      _buildCategory(context, Icons.format_paint, 'Cat'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Tukang Terdekat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF222831),
                  ),
                ),
              ],
            ),
          ),

          // LIST TUKANG (HASIL SEARCH)
          if (filteredTukangs.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'Tukang tidak ditemukan',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            )
          else
            ...filteredTukangs.map(
              (t) => TukangCard(
                tukang: t,
                onView: () => Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: {'tukang': t},
                ),
                onBook: () => Navigator.pushNamed(
                  context,
                  '/booking',
                  arguments: {'tukang': t},
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategory(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TukangListScreen(category: label),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: const Color(0xFF222831)),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
