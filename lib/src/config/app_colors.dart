import 'package:flutter/material.dart';

// ------------------------------------------------------------------
// 1. Primary Colors (주요 색상)
//    - 앱의 브랜드 컬러 및 강조 색상을 정의합니다.
// ------------------------------------------------------------------

/// 앱의 주 색상 (이전 CommonTabs의 파란색)
const Color kPrimaryColor = Color(0xFF0077CC);

/// 상호작용 또는 대비에 사용되는 강조 색상
const Color kAccentColor = Color(0xFFFFA500); // 예: 주황색

/// 일반적인 배경 색상 (이전 CommonTabs의 배경색)
const Color kScaffoldBackground = Color(0xFFF3F3F3);

// --- 이미지 분석 기반 추가 색상 ---

/// 상단 헤더, 그래프, 메인 액션 버튼 등 핵심 UI에 사용되는 청록색
const Color kBrandCyan = Color(0xFF00B0B0); // 이미지 상단 바 색상

/// 원형 그래프 내부 및 성공을 나타내는 밝은 청록색 (Success Blue 계열)
const Color kProgressBlue = Color(0xFF20C9C9); // 이미지 내 80% 그래프 색상

// ------------------------------------------------------------------
// 2. Status Colors (상태 표시 색상)
//    - 오류, 성공, 경고 등의 상태를 나타낼 때 사용합니다.
// ------------------------------------------------------------------

/// 오류 또는 삭제 작업에 사용되는 빨간색
const Color kErrorRed = Color(0xFFD32F2F);

/// 성공적인 작업 또는 긍정적인 상태에 사용되는 녹색
const Color kSuccessGreen = Color(0xFF388E3C);

/// 경고 또는 주의가 필요한 상황에 사용되는 주황색
const Color kWarningOrange = Color(0xFFF57C00);

// --- 이미지 분석 기반 추가 색상 ---

/// '진행 중' 상태 표시 등에 사용되는 밝고 활기찬 주황색
const Color kStatusInProgress = Color(0xFFFF9900); // 이미지 내 '진행 중' 원형 색상

/// '도전 실패' X 표시에 사용되는 부드러운 분홍빛 붉은색
const Color kStatusFailure = Color(0xFFE57373); // 이미지 내 '도전 실패' X 색상

/// '도전 성공' 체크 표시에 사용되는 진한 파란색
const Color kStatusSuccessCheck = Color(0xFF4A90E2); // 이미지 내 '도전 성공' 체크 색상

// ------------------------------------------------------------------
// 3. Text & Neutral Colors (텍스트 및 중립 색상)
//    - 글자색, 구분선, 그림자 등에 사용됩니다.
// ------------------------------------------------------------------

/// 어두운 배경에 사용되는 밝은 글자색
const Color kLightText = Colors.white;

/// 밝은 배경에 사용되는 어두운 글자색
const Color kDarkText = Color(0xFF212121);

/// 기본 회색 (구분선, 비활성화된 요소)
const Color kNeutralGray = Color(0xFF9E9E9E);

/// 아주 밝은 회색 (카드 또는 컨테이너 배경)
const Color kLightGray = Color(0xFFEEEEEE);
