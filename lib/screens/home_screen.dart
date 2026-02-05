import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
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
    final service = Provider.of<FirebaseService>(context, listen: false);

    return WillPopScope(
      // 🔥 BACK HP = KELUAR APLIKASI
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFDFD0B8),
        appBar: AppBar(
          automaticallyImplyLeading: false, // 🔥 HILANGKAN TOMBOL BACK
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
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SEARCH BOX
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

                  // CATEGORY
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

            // ================= LIST TUKANG =================
            StreamBuilder<List<Tukang>>(
              stream: service.getTukangs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'Tidak ada tukang',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  );
                }

                final allTukangs = snapshot.data!;

                final filteredTukangs = allTukangs.where((t) {
                  final q = searchQuery.toLowerCase();
                  return t.name.toLowerCase().contains(q) ||
                      t.expertise.toLowerCase().contains(q);
                }).toList();

                return Column(
                  children: filteredTukangs.map((t) {
                    return TukangCard(
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
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
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
