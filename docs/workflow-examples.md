# 업무 플로우 예시

DubDubDub Corp.의 AI-driven 업무 프로세스는 **Claude Code를 중심으로 모든 작업이 진행**됩니다.

## AI-Driven 업무의 핵심 원칙

1. **모든 문서화 및 개발 작업은 Claude Code와 소통하며 진행**
2. **Project Brain 및 팀원 처럼 활용**: Claude Code가 Jira, Confluence, GitHub 정보를 자동으로 처리
3. **자동화 우선**: 반복 작업은 Claude Code가 처리
4. **직군별 맞춤 활용**: 기획자, 디자이너, 개발자, QA 각자의 방식으로 활용

---

## 일일 업무 루틴 (AI-Driven)

### 출근 후 업무 시작 (모든 직군 공통)

```bash
# 1. Claude Code 실행
claude

# 2. 전일 대비 변경사항 브리핑 (AI가 자동으로 요약)
어제부터 오늘까지 Jira 이슈 변경사항과 GitHub 커밋 내역 브리핑해줘

# 3. 일일 스탠드업 확인
/daily-standup

# 4. 미할당 이슈 중 선택하여 할당
/assign-me PROJ-123

# 5. 오늘의 업무 계획 정리 (Claude Code가 도움)
오늘 처리할 이슈들을 우선순위별로 정리하고 예상 소요시간 알려줘

# 6. 업무 시작
```

**브리핑 예시 (Claude Code가 자동 생성)**:
```
📊 일일 브리핑 - 2025-11-07

📋 Jira 변경사항 (어제 ~ 오늘):
- [KAN-15] SEO 최적화 → In Progress (김명일)
- [KAN-6] 카피라이팅 → Done (김경호)
- 새 이슈 3개 생성됨

💻 GitHub 변경사항:
- main 브랜치: 5개 커밋 (김명일, sypark)
- PR #12 머지됨: "메인 페이지 UI 개발"
- 충돌 없음

✅ 오늘 할 일:
- [KAN-8] 메인 페이지 UI 개발 계속 (80% 완료)
- [KAN-10] 커리큘럼 섹션 시작
```

### 업무 진행 중
- Jira 이슈 상태 업데이트
- 진행 상황을 코멘트로 기록
- 필요시 Sub-Task 생성

### 업무 종료 전
- 진행 중인 이슈에 오늘 작업 내용 코멘트
- 완료한 이슈는 Done으로 상태 변경
- 내일 할 작업 메모

## 주간 업무 루틴 (AI-Driven)

### 월요일 (주간 계획)

```bash
# 1. Claude Code로 지난 주 완료 사항 요약
claude

지난 주 완료된 이슈들과 이번 주 계획할 이슈들을 Confluence에 주간 계획 페이지로 만들어줘

# 2. 주간 회의 전 보고서 자동 생성
/weekly-report

# 3. Claude Code가 mcp-atlassian으로 Jira 데이터 기반 요약
이번 주 스프린트의 이슈들을 우선순위별로 정리하고 리스크 있는 이슈를 알려줘

# 4. 주간 회의에서 공유
```

**Claude Code가 자동 생성하는 주간 계획 (Confluence)**:
```markdown
# 주간 계획 - 2025-11-04 ~ 11-08

## 지난 주 완료 사항 ✅
- [KAN-6] 메인 히어로 카피라이팅 완료 (김경호)
- [KAN-7] 이벤트 소개 콘텐츠 작성 완료 (김경호)
- [KAN-8] 메인 페이지 UI 개발 80% 완료 (김명일)

## 이번 주 목표 🎯
- [KAN-8] 메인 페이지 UI 개발 완료
- [KAN-10] 커리큘럼 섹션 UI 개발 시작 → 완료
- [KAN-15] SEO 최적화 완료

## 리스크 및 블로커 ⚠️
- [KAN-13] 파트너사 로고 수집 지연 중 (25개 중 15개만 수집)
  → 김경호님께 리마인드 필요

## 예상 작업량
- Story Point 합계: 21
- 팀 Velocity: 18~22
- 평가: 적정 수준
```

### 금요일 (주간 마무리)

```bash
# 1. Claude Code로 이번 주 완료 사항 자동 집계
claude

이번 주 완료한 이슈들을 기반으로 Confluence에 주간 완료 보고서 작성해줘

# 2. 주간 보고서 자동 생성 및 Confluence 업데이트
/weekly-report

# 3. 미완료 작업 다음 주로 이월 (Claude Code가 자동 처리)
미완료된 이슈들을 다음 스프린트로 이동하고 Jira에 코멘트 남겨줘

# 4. 다음 주 계획 초안 (Claude Code가 제안)
다음 주 해야 할 이슈들을 우선순위별로 제안해줘
```

## 신입 직원 온보딩 플로우

### 1일차: 환경 설정
```bash
# 1. 리포지토리 클론
git clone https://github.com/ww-w-ai/AI-driven-work.git
cd AI-driven-work

# 2. 환경 설정 스크립트 실행
./scripts/setup.sh

# 3. Jira, Confluence 계정 확인
# 4. API 토큰 발급 및 설정
```

### 2일차: 문서 숙지
- `docs/jira-guidelines.md` 읽기
- `docs/confluence-guidelines.md` 읽기
- `docs/claude-code-guide.md` 읽기
- 회사 Confluence 탐색

### 3일차: 실습
```bash
# 1. 간단한 이슈 할당받기
/daily-standup
/assign-me ONBOARDING-001

# 2. 이슈 처리
# 3. 완료 후 보고
```

### 1주차: 멘토링
- 팀 멤버와 페어 프로그래밍
- 코드 리뷰 프로세스 학습
- 질문 및 피드백

---

## 직군별 AI-Driven 워크플로우

### 기획자 (PM/PO) 워크플로우

#### 1. 요구사항 수집 및 문서화

```bash
# 고객 미팅 후
claude

고객 요구사항을 정리해서 Confluence에 "신규 기능 요구사항" 페이지로 작성해줘:
- 기능명: 사용자 프로필 수정
- 배경: 사용자가 프로필 사진을 변경하고 싶어함
- 요구사항: [미팅 노트 붙여넣기]
```

**Claude Code가 자동 생성하는 문서 구조**:
```markdown
# 요구사항 정의서: 사용자 프로필 수정 기능

## 배경 및 목적
...

## 사용자 스토리
- As a 사용자, I want to ...

## 기능 요구사항
1. 프로필 사진 업로드
2. 닉네임 변경
...

## 비기능 요구사항
- 성능: 업로드 3초 이내
...

## 수용 기준
- [ ] ...
```

#### 2. Jira 이슈 생성 (Claude Code와 함께)

```bash
# Confluence 문서를 보고 Epic/Story 생성
Confluence의 "사용자 프로필 수정 기능" 문서를 보고 Jira에 Epic과 Story들을 생성해줘

# Claude Code가 자동으로:
# - Epic 1개 생성
# - Story 5개 생성
# - Sub-Task 자동 분배
```

#### 3. 백로그 관리

```bash
# 매주 백로그 정리
현재 백로그에서 우선순위가 높은 이슈 10개를 보여주고, 다음 스프린트에 넣을 만한 이슈를 추천해줘
```

---

### 디자이너 워크플로우

#### 1. 요구사항 파악 (Confluence 문서 기반)

```bash
claude

# Confluence에서 요구사항 문서 읽기
PROJ-123 이슈와 관련된 Confluence 문서를 찾아서 요약해줘
```

#### 2. 목업 페이지 제작 (Claude Code와 소통)

```bash
# HTML/CSS/JavaScript로 인터랙티브 목업 제작
claude

요구사항 문서를 기반으로 사용자 프로필 수정 화면의 HTML 목업을 만들어줘:
- 반응형 디자인
- 프로필 사진 업로드 UI
- 닉네임 입력 폼
- 저장 버튼

# Claude Code가 생성:
# - profile-edit.html
# - styles.css
# - script.js (화면 전이 포함)
# - mock-data.json (목업 데이터)
```

#### 3. 목업 페이지로 고객과 Output 인식 맞춤

```bash
# 목업 페이지 실행
open profile-edit.html

# 고객 피드백 받은 후
claude

고객 피드백을 반영해서 목업 수정해줘:
- 프로필 사진 크기를 150px로 키우기
- 저장 버튼을 오른쪽 상단으로 이동
```

#### 4. 최종 디자인을 Confluence에 문서화

```bash
완성된 목업 페이지의 스크린샷과 설명을 Confluence의 "UI/UX 디자인" 페이지에 추가해줘
```

---

### 개발자 워크플로우

#### 1. 설계 문서 파악 (Confluence 기반)

```bash
claude

# 이슈와 관련된 설계 문서 읽기
KAN-8 이슈와 관련된 Confluence 설계 문서를 요약하고, 개발에 필요한 핵심 사항을 알려줘
```

#### 2. 코드 개발 (Claude Code와 협업)

```bash
# 개발 컨벤션, Template 코드베이스, rules를 활용
claude

# 코드베이스의 컨벤션을 따라 개발
@codebase-convention.md 를 참고해서 사용자 프로필 수정 API를 개발해줘:
- RESTful API 설계
- Express.js 사용
- MongoDB 저장
- 파일 업로드는 AWS S3

# Claude Code가:
# - routes/profile.js 생성
# - controllers/profileController.js 생성
# - models/User.js 업데이트
# - 테스트 파일 생성
```

#### 3. 코드 리뷰 준비

```bash
# PR 생성 전 자동 체크
이 코드를 리뷰해줘. 보안 이슈, 성능 문제, 컨벤션 위반 사항을 확인해줘

# Claude Code가 분석:
# - SQL Injection 위험 확인
# - N+1 쿼리 문제 체크
# - 코딩 컨벤션 검증
```

#### 4. GitHub PR 생성

```bash
# PR 설명 자동 생성
git add . && git commit -m "PROJ-123: 사용자 프로필 수정 API 개발"

KAN-8 이슈를 기반으로 PR 설명을 작성해줘
```

---

### QA 엔지니어 워크플로우

#### 1. 테스트 시나리오 작성 (Claude Code와 협업)

```bash
claude

# Confluence 설계서와 구현 코드를 보고 시나리오 작성
KAN-8 이슈의 Confluence 설계서와 코드베이스를 분석해서 QA 테스트 시나리오를 Confluence에 작성해줘

# Claude Code가 생성하는 시나리오:
## 테스트 시나리오: 사용자 프로필 수정

### TC-001: 프로필 사진 업로드 성공
- Given: 로그인한 사용자
- When: 2MB 이하의 JPG 파일 업로드
- Then: 프로필 사진이 변경됨

### TC-002: 파일 크기 초과
- Given: 로그인한 사용자
- When: 10MB의 파일 업로드 시도
- Then: "파일 크기는 5MB 이하여야 합니다" 에러 메시지
```

#### 2. 테스트 스크립트 자동 생성

```bash
# Playwright 또는 Jest로 테스트 스크립트 생성
테스트 시나리오를 기반으로 Playwright E2E 테스트 스크립트를 생성해줘

# Claude Code가 생성:
# tests/e2e/profile-edit.spec.js
```

#### 3. 테스트 데이터 생성

```bash
테스트에 필요한 목업 데이터를 JSON 파일로 생성해줘:
- 사용자 10명
- 각 사용자별 프로필 정보
- 다양한 엣지 케이스 포함

# Claude Code가 생성:
# tests/fixtures/users.json
# tests/fixtures/invalid-files.json
```

#### 4. 테스트 실행 및 결과 보고서 작성

```bash
# 개발자가 테스트 실행
npm test

# 테스트 결과를 Claude Code가 Confluence에 보고서 작성
테스트 결과를 분석해서 Confluence에 "QA 테스트 결과 보고서" 작성해줘:
- 통과율
- 실패한 테스트 케이스
- 버그 리포트
```

**Claude Code가 생성하는 테스트 결과 보고서**:
```markdown
# QA 테스트 결과 보고서 - KAN-8

## 테스트 요약
- 실행 일시: 2025-11-07 14:30
- 총 테스트: 25개
- 통과: 23개 (92%)
- 실패: 2개 (8%)

## 실패한 테스트
### TC-003: 대용량 파일 업로드
- 상태: ❌ Failed
- 원인: 타임아웃 (10초 초과)
- 심각도: Medium
- Jira 이슈: KAN-25 생성됨

## 배포 판정
✅ **배포 가능** (Minor 버그 2건, Hot fix로 처리 예정)
```

---

### 출시 프로세스 (AI-Driven)

#### 1. 스프린트 완료 전 체크

```bash
claude

# 현재 스프린트의 모든 이슈 상태 확인
현재 스프린트의 이슈들을 확인하고 배포 준비 상태를 알려줘
```

#### 2. 출시 노트 자동 생성

```bash
# GitAction과 Jira Sprint를 기반으로 생성
claude

이번 스프린트에서 완료된 이슈들을 기반으로 출시 노트를 작성해줘:
- Jira Sprint: Sprint 5
- GitHub Release: v1.2.0
- 대상: 고객 및 내부 팀

# Claude Code가 자동 생성:
# - CHANGELOG.md 업데이트
# - GitHub Release Notes
# - Confluence 출시 노트 페이지
```

**Claude Code가 생성하는 출시 노트**:
```markdown
# Release v1.2.0 - 2025-11-08

## 🎉 새로운 기능
- **사용자 프로필 수정**: 프로필 사진 업로드 및 닉네임 변경 ([KAN-8])
- **SEO 최적화**: 검색엔진 노출 개선 ([KAN-15])

## 🐛 버그 수정
- 로그인 페이지 반응형 이슈 수정 ([KAN-20])

## 🔧 개선사항
- API 응답 속도 30% 개선 ([KAN-22])

## 📊 통계
- 완료된 이슈: 8개
- 해결된 버그: 3개
- 참여 인원: 5명
```

#### 3. 배포 및 모니터링

```bash
# 배포 후 모니터링
claude

배포 후 1시간 동안의 에러 로그를 분석하고 이상이 있으면 알려줘
```

---

## 빠른 개발 사이클 (스프린트 기반)

### 2주 스프린트 예시

| 일정 | 활동 | Claude Code 활용 |
|-----|------|------------------|
| **월요일** | 스프린트 계획 | Jira 백로그 분석 및 우선순위 제안 |
| **화~목** | 개발 진행 | 일일 브리핑, 코드 작성 지원 |
| **금요일** | QA 테스트 | 테스트 시나리오 및 스크립트 생성 |
| **다음 주 월~수** | 버그 수정 | 버그 분석 및 수정 지원 |
| **목요일** | 배포 준비 | 출시 노트 자동 생성 |
| **금요일** | 배포 및 회고 | 스프린트 회고록 Confluence 작성 |

### 회고 (Retrospective)

```bash
claude

이번 스프린트를 회고해서 Confluence에 회고록을 작성해줘:
- 잘한 점 (Keep)
- 개선할 점 (Problem)
- 시도할 것 (Try)
```

---

## 이슈 생성부터 완료까지 (AI-Driven)

### 1. 이슈 발견 및 생성 (Claude Code와 함께)

```bash
# 상황: 버그 발견 또는 개선 아이디어
claude

# Claude Code에게 이슈 생성 요청
Jira에 버그 이슈를 생성해줘:
- 제목: 로그인 페이지가 모바일에서 깨짐
- 재현 방법:
  1. 아이폰 Safari에서 로그인 페이지 접속
  2. 이메일 입력 폼이 화면 밖으로 벗어남
- 우선순위: High
- 담당자: 미할당

# Claude Code가:
# - 적절한 이슈 타입 판단 (Bug)
# - 자세한 설명 작성
# - 라벨 자동 추가 (frontend, mobile, urgent)
# - Jira에 이슈 생성: PROJ-456
```

### 2. 이슈 할당 (자율적 선택)

```bash
# 다음 날 아침, 팀원이 /daily-standup으로 확인
/daily-standup

# 출력:
📋 미할당 이슈
- [PROJ-456] 로그인 페이지가 모바일에서 깨짐 (High) 👈 긴급!

# 처리 가능한 이슈 선택
/assign-me PROJ-456

# Claude Code가 자동으로:
# - Jira에서 담당자를 본인으로 지정
# - 이슈에 코멘트 추가: "작업 시작합니다"
```

### 3. 이슈 처리 (Claude Code와 협업)

```bash
# 1. 이슈 상태를 "In Progress"로 변경
PROJ-456을 In Progress로 변경해줘

# 2. 작업 수행 (Claude Code와 함께)
claude

로그인 페이지의 모바일 반응형 이슈를 수정해줘.
코드베이스를 분석하고 수정 방법을 알려줘.

# Claude Code가:
# - 코드 분석
# - 문제 원인 파악
# - 수정 코드 제안

# 3. 진행 상황 Jira에 코멘트
PROJ-456에 코멘트 남겨줘: "CSS 미디어 쿼리 수정 완료. QA 테스트 요청"

# 4. 코드 커밋 (이슈 키 포함)
git add .
git commit -m "PROJ-456: 로그인 페이지 모바일 반응형 수정"
```

### 4. 이슈 완료 (자동화)

```bash
# 1. 작업 완료 확인 (Claude Code가 체크리스트 생성)
PROJ-456의 완료 기준을 확인해줘

# 2. 테스트 완료
# QA 엔지니어가 테스트 후 승인

# 3. PR 생성 (Claude Code가 설명 자동 작성)
KAN-8 이슈를 기반으로 PR 설명을 작성해줘

# Claude Code가 생성한 PR 설명:
## 변경 사항
- 로그인 페이지 CSS 미디어 쿼리 추가
- iPhone/Android 모두 대응

## 테스트
- [x] iPhone Safari 확인
- [x] Android Chrome 확인
- [x] 기존 데스크톱 레이아웃 정상 작동

## 관련 이슈
- Fixes PROJ-456

# 4. 머지 후 이슈 자동 완료
gh pr merge 123

# Claude Code가 자동으로:
# - Jira 이슈를 "Done"으로 변경
# - 완료 코멘트 추가
# - 관련 문서 업데이트 제안
```

## 긴급 상황 대응 (AI-Driven)

### 프로덕션 버그 발생

```bash
# 1. Claude Code로 즉시 긴급 이슈 생성
claude

프로덕션 버그 발생! Jira에 긴급 이슈 생성해줘:
- 제목: 결제 API 타임아웃 발생
- 심각도: Critical
- 영향 범위: 모든 사용자 결제 불가
- 발생 시간: 2025-11-07 14:23
- 우선순위: Highest

# Claude Code가 자동으로:
# - 긴급 이슈 생성 (PROJ-999)
# - 라벨: production, urgent, critical
# - Slack 알림 자동 전송

# 2. 즉시 담당자 할당 (시니어 개발자)
/assign-me PROJ-999

# 3. Claude Code와 함께 빠른 원인 분석
에러 로그를 분석하고 원인을 파악해줘:
[에러 로그 붙여넣기]

# Claude Code가:
# - 에러 로그 분석
# - 가능한 원인 3가지 제시
# - 즉시 조치 방법 제안

# 4. 핫픽스 진행
제안된 방법으로 핫픽스 코드를 작성해줘

# 5. 배포 후 사후 분석 문서 자동 생성
PROJ-999의 사후 분석 보고서를 Confluence에 작성해줘:
- 발생 원인
- 영향 범위
- 해결 방법
- 재발 방지 계획
```

**Claude Code가 생성하는 사후 분석 보고서**:
```markdown
# 프로덕션 장애 보고서 - PROJ-999

## 장애 요약
- 발생 일시: 2025-11-07 14:23
- 해결 일시: 2025-11-07 15:10
- 영향 시간: 47분
- 영향 범위: 모든 결제 시도 실패

## 원인 분석
...

## 재발 방지 계획
1. API 타임아웃 설정 조정
2. 모니터링 알람 임계값 조정
3. 서킷 브레이커 패턴 도입
```

### 서버 장애

```bash
# 1. 모니터링 도구에서 알람 확인 후
claude

서버 장애 발생. Jira 인시던트 티켓 생성하고 현황을 Confluence에 실시간 업데이트해줘

# 2. Claude Code가:
# - Jira 인시던트 티켓 생성
# - Confluence에 "서버 장애 현황" 실시간 페이지 생성
# - Slack에 장애 알림

# 3. 장애 대응 진행
현재 서버 상태를 분석하고 조치 방법을 알려줘

# 4. 복구 후 원인 분석 및 문서화
장애 복구 완료. 전체 과정을 Confluence에 타임라인으로 정리해줘
```

---

## 협업 시나리오 (AI-Driven)

### 코드 리뷰

```bash
# 1. PR 생성 (Claude Code가 자동 링크)
git commit -m "PROJ-123: 사용자 프로필 API"
gh pr create

# PR 설명을 Jira PROJ-123 기반으로 작성해줘

# Claude Code가:
# - Jira 이슈 내용 읽기
# - PR 설명 자동 생성
# - 관련 이슈 자동 링크

# 2. 리뷰어에게 자동 알림
# Claude Code가 적합한 리뷰어 제안

# 3. 리뷰어가 Claude Code로 코드 분석
claude

# PR #45의 코드를 리뷰해줘. 특히 다음 사항 확인:
# - 보안 이슈
# - 성능 문제
# - 테스트 커버리지
# - 코딩 컨벤션

# Claude Code가 리뷰 리포트 생성:
## 보안 ✅
- SQL Injection 방어 확인됨
- XSS 방어 확인됨

## 성능 ⚠️
- N+1 쿼리 발견 (line 45)
  → 제안: eager loading 사용

## 테스트 ✅
- 커버리지 85% (목표 80% 달성)

## 컨벤션 ⚠️
- 함수명 camelCase 위반 (line 23)

# 4. 피드백 반영 후 머지
gh pr merge 45

# 5. Claude Code가 Jira 자동 업데이트
```

### 페어 프로그래밍 (Claude Code가 중재자 역할)

```bash
# 1. 함께 작업할 이슈 선택
claude

PROJ-150 이슈를 페어 프로그래밍으로 진행하려고 해.
김명일님과 sypark님의 역할을 Sub-Task로 나눠줘

# Claude Code가 자동으로:
# - Sub-Task 1: API 개발 (김명일)
# - Sub-Task 2: 프론트엔드 개발 (sypark)
# - Sub-Task 3: 통합 테스트 (공동)

# 2. 실시간 협업 (Claude Code가 코드 통합 지원)
# Driver: 김명일 (코드 작성)
# Navigator: sypark (리뷰 및 제안)

claude

# 현재 API 코드를 보고 프론트엔드에서 어떻게 호출해야 하는지 예시 코드 만들어줘

# 3. 정기적인 스위칭 (30분마다)
# Claude Code가 타이머 알림

# 4. 완료 후 통합
두 Sub-Task의 작업 내용을 통합하고 충돌이 없는지 확인해줘
```

### 크로스 팀 협업 (기획 + 디자인 + 개발)

```bash
# 상황: 신규 기능 개발 시작

# 1. 기획자가 Confluence에 요구사항 작성 (Claude Code 도움)
고객 미팅 내용을 바탕으로 요구사항 정의서 작성해줘

# 2. 디자이너가 Confluence 문서를 읽고 목업 제작
PROJ-200 관련 Confluence 문서를 보고 목업 페이지 만들어줘

# 3. 개발자가 설계 문서와 목업을 보고 개발
PROJ-200의 설계서와 목업을 분석해서 개발 계획을 세워줘

# 4. QA가 테스트 시나리오 작성
PROJ-200의 요구사항을 보고 테스트 시나리오 작성해줘

# 5. Claude Code가 전체 진행 상황을 Confluence에 요약
PROJ-200 프로젝트의 전체 진행 상황을 대시보드 형태로 Confluence에 정리해줘
```

## 프로젝트 킥오프 (AI-Driven)

### 새 프로젝트 시작

```bash
# 1. Claude Code로 프로젝트 구조 자동 생성
claude

신규 프로젝트를 시작하려고 해:
- 프로젝트명: 사용자 멤버십 시스템
- 목표: 사용자에게 구독 기반 멤버십 제공
- 기간: 2개월
- 팀: 기획 1명, 디자인 1명, 개발 2명, QA 1명

Jira에 Epic과 Story 구조를 만들고, Confluence에 프로젝트 페이지도 생성해줘

# Claude Code가 자동으로:
# - Jira Epic 생성: "사용자 멤버십 시스템 구축"
# - 주요 Story 5개 자동 생성:
#   - 멤버십 플랜 선택 기능
#   - 결제 연동
#   - 멤버십 혜택 적용
#   - 관리자 대시보드
#   - 알림 기능
# - Confluence 프로젝트 페이지 생성 (템플릿 기반)

# 2. 팀 킥오프 미팅 준비 (Claude Code가 자료 생성)
킥오프 미팅 자료를 Confluence에 작성해줘:
- 프로젝트 개요
- 목표 및 성공 지표
- 팀 구성 및 역할
- 일정 및 마일스톤
- 리스크 및 의존성

# 3. 초기 Story 할당 제안
팀 구성원별로 적합한 초기 Story를 제안해줘
```

**Claude Code가 생성하는 Confluence 프로젝트 페이지**:
```markdown
# 프로젝트: 사용자 멤버십 시스템

## 개요
사용자에게 구독 기반 멤버십 서비스를 제공

## 목표
- 월간 활성 멤버십 구독자 1,000명
- 이탈률 5% 이하
- 평균 구독 기간 6개월 이상

## 팀 구성
| 역할 | 이름 | 책임 |
|-----|------|------|
| PM | sypark | 전체 프로젝트 관리 |
| 디자이너 | 김경호 | UI/UX 디자인 |
| 개발자 | 김명일 | 백엔드 개발 |
| QA | ... | 테스트 |

## 마일스톤
- Week 2: 기획 및 디자인 완료
- Week 4: 핵심 기능 개발 완료
- Week 6: QA 및 버그 수정
- Week 8: 배포 및 모니터링

## 관련 링크
- Jira Epic: [PROJ-300]
- 디자인 Figma: ...
- API 문서: ...
```

### 스프린트 계획 (AI-Driven)

```bash
# 1. Claude Code로 백로그 자동 정리
claude

현재 백로그를 분석하고 다음 스프린트에 적합한 이슈들을 추천해줘:
- 팀 Velocity: 20 포인트
- 스프린트 기간: 2주
- 우선순위 고려

# Claude Code가:
# - 백로그 분석
# - 의존성 확인
# - 우선순위별 정렬
# - Story Point 기반 추천

# 2. 스프린트 목표 설정 (Claude Code가 제안)
이번 스프린트의 목표를 제안해줘

# Claude Code 제안:
## Sprint 5 목표
- 멤버십 플랜 선택 UI 완성
- 결제 API 연동 완료
- 기본 멤버십 혜택 적용 기능 개발

# 3. Story 포인트 추정 (Claude Code 참고 자료 제공)
각 Story의 복잡도를 분석하고 Story Point 추정을 도와줘

# 4. 스프린트에 이슈 할당
추천된 이슈들을 Sprint 5에 추가해줘

# 5. 스프린트 계획을 Confluence에 문서화
Sprint 5 계획을 Confluence에 정리해줘
```

---

## AI-Driven 업무의 핵심 성공 요인

### 1. Claude Code를 만능 팀원처럼 활용
- 단순한 코딩 도구가 아닌 **업무 파트너**로 활용
- 반복 작업, 문서화, 분석은 모두 Claude Code에게 위임

### 2. 모든 정보는 Jira와 Confluence에
- **단일 진실 공급원(Single Source of Truth)**
- Claude Code가 언제든 정보를 읽고 활용할 수 있도록

### 3. 자동화 우선 사고
- "이걸 매번 해야 하나?" → Claude Code에게 자동화 요청
- Slash command, skill, rules로 반복 작업 제거

### 4. 직군별 맞춤 활용
- 기획자: 문서화 자동화
- 디자이너: 목업 제작 지원
- 개발자: 코드 작성 및 리뷰
- QA: 테스트 자동화

### 5. 지속적인 개선
- 매 스프린트 회고에서 Claude Code 활용 방법 개선
- 팀 전체가 베스트 프랙티스 공유

---

**작성일**: 2025-11-07
**작성자**: Claude Code
**버전**: 2.0 (AI-Driven 업무 프로세스 반영)
**대상**: DubDubDub Corp. 전 직원
