import 'package:flutter/material.dart';

class GundoriCollectPage extends StatelessWidget {
  const GundoriCollectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // (2) 획득 배너 영역
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(16),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 20, color: Colors.grey.shade300), // 텍스트 자리
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  7,
                  (i) => Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),

        // (3) 설명 영역
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 200, height: 20, color: Colors.grey.shade300),
              Container(width: 60, height: 20, color: Colors.grey.shade300),
            ],
          ),
        ),

        // (4) 지도 영역
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // 실제 지도 들어갈 자리
                Center(
                  child: Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey.shade400,
                  ),
                ),

                // 마커 자리
                Positioned(left: 40, top: 40, child: _mapPlaceholder()),
                Positioned(left: 160, top: 120, child: _mapPlaceholder()),
                Positioned(right: 40, bottom: 80, child: _mapPlaceholder()),
              ],
            ),
          ),
        ),

        // (5) 하단 안내 문구
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(width: 250, height: 16, color: Colors.grey.shade300),
        ),
      ],
    );
  }

  // 지도 내 마커 placeholder
  Widget _mapPlaceholder() {
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
