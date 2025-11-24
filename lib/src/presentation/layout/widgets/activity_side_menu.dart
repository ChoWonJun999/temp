import 'package:app/src/presentation/layout/shell_layout.dart';
import 'package:flutter/material.dart';

class ActivitySideMenu extends StatelessWidget {
  final VoidCallback onClose;
  final void Function(MainScreenType type, String title) onSelect;

  const ActivitySideMenu({
    super.key,
    required this.onClose,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 정보 영역
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 100, height: 16),
                  SizedBox(width: 60, height: 14),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onClose,
                child: const Icon(Icons.close, size: 26),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 버튼 2개 (마이페이지 / 로그아웃)
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF00A8CC),
            width: double.infinity,
            child: const Text(
              "걷기",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          _menuItem("걷기 활동", MainScreenType.home),
          _menuItem("걷돌이 모으기", MainScreenType.gundori),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF00A8CC),
            width: double.infinity,
            child: const Text(
              "커뮤니티",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          _menuItem("기타 메뉴 1", MainScreenType.home),
          _menuItem("기타 메뉴 2", MainScreenType.home),
        ],
      ),
    );
  }

  Widget _menuItem(String label, MainScreenType type) {
    return GestureDetector(
      onTap: () => onSelect(type, label),
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
