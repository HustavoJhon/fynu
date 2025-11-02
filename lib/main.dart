import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/dependency_injection.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/collection_page.dart';
import 'presentation/pages/girlfriend_page.dart';
import 'presentation/viewmodels/home_viewmodel.dart';
import 'presentation/viewmodels/collection_viewmodel.dart';
import 'presentation/viewmodels/girlfriend_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const FynuApp());
}

class FynuApp extends StatelessWidget {
  const FynuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<HomeViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<CollectionViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<GirlfriendViewModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Fynu',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CollectionPage(),
    const GirlfriendPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1F1F1F),
          selectedItemColor: const Color(0xFFE50914),
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              label: 'Mi Colección',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Con mi novia',
            ),
          ],
        ),
      ),
    );
  }
}
