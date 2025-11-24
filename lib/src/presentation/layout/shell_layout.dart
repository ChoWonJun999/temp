import 'package:app/src/presentation/layout/widgets/activity_side_menu.dart';
import 'package:app/src/presentation/pages/gundori/gundori_collect_page.dart';
import 'package:app/src/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';

enum MainScreenType { home, gundori }

class ShellLayout extends StatefulWidget {
  final MainScreenType initialScreen;

  const ShellLayout({super.key, this.initialScreen = MainScreenType.home});

  @override
  State<ShellLayout> createState() => _ShellLayoutState();
}

class _ShellLayoutState extends State<ShellLayout> {
  bool isMenuOpen = false;
  MainScreenType currentScreen = MainScreenType.home;
  String currentTitle = "걷기 활동";

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 메인 화면
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildScreen()),
              ],
            ),
          ),

          /// 어두운 배경
          if (isMenuOpen)
            GestureDetector(
              onTap: () => setState(() => isMenuOpen = false),
              // ignore: deprecated_member_use
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

          /// 슬라이드 메뉴
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            left: isMenuOpen ? 0 : -280,
            top: 0,
            bottom: 0,
            child: SafeArea(
              child: ActivitySideMenu(
                onClose: () => setState(() => isMenuOpen = false),
                onSelect: (screenType, title) {
                  setState(() {
                    currentScreen = screenType;
                    currentTitle = title;
                    isMenuOpen = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 화면 매핑
  Widget _buildScreen() {
    switch (currentScreen) {
      case MainScreenType.home:
        return const HomePage();
      case MainScreenType.gundori:
        return const GundoriCollectPage();
    }
  }

  /// 상단바
  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFF00A8CC),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => isMenuOpen = true),
            child: const Icon(Icons.menu, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 12),
          Text(
            currentTitle,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
