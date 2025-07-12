
# 🐾 Frontend-for-AI-based-dog-image-generation-side-project

Flutter 기반 반려견 AI 이미지 생성 프로젝트의 프론트엔드입니다.  
백엔드와의 연동을 통해 사용자로부터 이미지를 입력받고, 세부 정보를 기반으로 AI 이미지 생성 요청을 처리하며,  
이미지 갤러리, 구독 관리, 로그인/회원가입 등 **풀 스택 모바일 사용자 경험**을 제공합니다.

---

## 📱 프로젝트 개요

이 앱은 사용자가 반려견 이미지를 업로드하고, 품종/표정/테마 등을 선택하여 **Stable Diffusion 기반 AI 이미지**를 생성 요청하는 모바일 앱입니다.  
Flutter와 Riverpod 상태관리, Dio 기반 API 연동, 보안 저장소와 스플래시, 테마, 캐시 등 **모던한 앱 개발 스택**을 적극 활용합니다.

---

## ✅ 주요 기능

- 로그인 / 회원가입 / 비밀번호 초기화 & 변경
- 반려견 사진 업로드 + 상세 옵션 입력
- AI 이미지 생성 요청 및 결과 이미지 확인
- 이미지 갤러리 조회, 이미지 다운로드
- 사용자 프로필, 구독 정보 관리
- 테마 기반 프롬프트 자동 생성
- Flutter Secure Storage 기반 JWT 저장
- 커스텀 예외 처리 및 에러 화면 구성

---

## 🧱 프로젝트 구조 (일부)

```
lib/
├── apis/                 # 백엔드 API 연동 (Dio 기반)
├── components/           # UI 재사용 컴포넌트
├── interceptor/          # 인증/로깅 인터셉터
├── models/               # 요청/응답 DTO
├── screens/              # 화면 별 UI
├── services/             # 로직 서비스
├── viewmodels/           # Riverpod 상태 관리
├── helper/               # 유틸리티
├── main.dart             # 앱 진입점
```

---

## 🛠 사용 기술

| 영역 | 기술 |
|------|------|
| Language | Dart |
| Framework | Flutter (3.x 이상) |
| State Management | Riverpod |
| HTTP | Dio, Interceptor |
| Storage | flutter_secure_storage, shared_preferences |
| Image | image_picker, cached_network_image |
| 기타 | json_serializable, freezed, flutter_native_splash

---

## ⚙️ 상태 관리 구조

- **Riverpod 기반 MVVM 패턴**
- ViewModel ↔ Model ↔ Service ↔ API로 의존성 분리
- `galleries_view_model`, `picture_create_view_model` 등 기능 단위로 상태 관리

---

## 💡 UX/UI 특징

- Flutter Material 디자인
- 사용자 친화적 입력 폼 및 에러 처리
- 토스트 기반 알림
- 이미지 캐싱 최적화

---

## 📦 버전 및 환경

- Flutter SDK: >=3.0.0 <4.0.0
- Dart SDK: >=3.0.0
