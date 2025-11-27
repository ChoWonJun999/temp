import 'package:flutter/material.dart';

// 1. 상태를 관리하는 StatefulWidget
class ContentSwitcherBar extends StatefulWidget {
  // ⭐️ 위젯이 변경될 중앙 콘텐츠 리스트
  final List<Widget> contentWidgets;

  // 현재 날짜/페이지 인덱스 변경 시 호출할 콜백 함수 (선택 사항)
  final ValueChanged<int>? onIndexChanged;

  const ContentSwitcherBar({
    super.key,
    required this.contentWidgets,
    this.onIndexChanged,
  });

  @override
  State<ContentSwitcherBar> createState() => _ContentSwitcherBarState();
}

class _ContentSwitcherBarState extends State<ContentSwitcherBar> {
  // 2. 현재 상태(인덱스) 저장
  int _currentIndex = 0;

  // 3. 이전(왼쪽)으로 이동하는 함수
  void _goToPrevious() {
    setState(() {
      // 인덱스를 감소시키되, 0 미만으로 내려가지 않도록 합니다.
      _currentIndex = (_currentIndex - 1).clamp(
        0,
        widget.contentWidgets.length - 1,
      );
      widget.onIndexChanged?.call(_currentIndex);
    });
  }

  // 4. 다음(오른쪽)으로 이동하는 함수
  void _goToNext() {
    setState(() {
      // 인덱스를 증가시키되, 최대 길이(last index)를 넘지 않도록 합니다.
      _currentIndex = (_currentIndex + 1).clamp(
        0,
        widget.contentWidgets.length - 1,
      );
      widget.onIndexChanged?.call(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 5. 이전 위젯에서 제안한 레이아웃 구조 사용 (양쪽 화살표는 IconButton으로 클릭 기능 부여)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ⬅️ 이전 버튼
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, size: 20),
            onPressed: _currentIndex > 0
                ? _goToPrevious
                : null, // 첫 페이지에서는 비활성화
          ),

          // 📅 중앙 콘텐츠: 현재 인덱스에 해당하는 위젯 표시
          widget.contentWidgets[_currentIndex],

          // ➡️ 다음 버튼
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onPressed: _currentIndex < widget.contentWidgets.length - 1
                ? _goToNext
                : null, // 마지막 페이지에서는 비활성화
          ),
        ],
      ),
    );
  }
}
