# GitHub 워크플로우 및 브랜치 전략

> **프로젝트**: AI-driven-work (오픈소스)
> **리포지토리**: https://github.com/ww-w-ai/AI-driven-work
> **작성일**: 2025-11-08
> **작성자**: 김경호 (popup-kay)

---

## 목차

1. [브랜치 전략](#브랜치-전략)
2. [머지 전략](#머지-전략)
3. [PR 워크플로우](#pr-워크플로우)
4. [GitHub 저장소 설정](#github-저장소-설정)
5. [작업 흐름](#작업-흐름)
6. [커밋 메시지 규칙](#커밋-메시지-규칙)
7. [코드 리뷰 가이드](#코드-리뷰-가이드)

---

## 브랜치 전략

### 브랜치 구조

```
main (프로덕션 - 안정 버전)
  └── develop (개발 - 다음 릴리스)
        ├── feature/* (기능 개발)
        ├── bugfix/* (버그 수정)
        ├── docs/* (문서 개선)
        └── hotfix/* (긴급 수정, main에서 분기)
```

### 브랜치 설명

| 브랜치 | 용도 | 보호 설정 | 배포 |
|--------|------|----------|------|
| **main** | 프로덕션 안정 버전 | 🔒 Protected | 자동 배포 (릴리스 시) |
| **develop** | 개발 통합 브랜치 | 🔒 Protected | 없음 |
| **feature/*** | 새 기능 개발 | - | 없음 |
| **bugfix/*** | 버그 수정 | - | 없음 |
| **docs/*** | 문서 개선 | - | 없음 |
| **hotfix/*** | 긴급 패치 | - | 검증 후 main 머지 |

### 브랜치 네이밍 규칙

```bash
# 기능 개발
feature/<기능명>
예: feature/jira-rules-setup
예: feature/confluence-integration

# 버그 수정
bugfix/<이슈번호-버그명>
예: bugfix/42-script-permission
예: bugfix/setup-error-handling

# 문서 개선
docs/<문서명>
예: docs/update-readme
예: docs/add-troubleshooting

# 긴급 패치
hotfix/<이슈번호-패치명>
예: hotfix/critical-security-fix
예: hotfix/51-env-file-leak
```

---

## 머지 전략

### ⭐ 핵심 규칙 (절대 준수)

**1. feature/bugfix/docs → develop: Squash and merge**
   - GitHub PR에서 **"Squash and merge"** 선택
   - 여러 커밋을 **1개로 압축**
   - Feature 브랜치는 머지 후 **자동 삭제**
   - 이유: 히스토리를 깔끔하게 유지

**2. develop → main: Merge commit**
   - GitHub PR에서 **"Create a merge commit"** 선택 (기본값)
   - develop의 모든 커밋을 main에 **그대로 머지**
   - 두 브랜치 모두 유지
   - 이유: 릴리스 단위로 명확한 이력 관리

**3. hotfix → main: Merge commit**
   - 긴급 패치는 main에 직접 머지
   - 머지 후 즉시 develop에도 백포트
   - 두 브랜치 동기화 유지

### 머지 전략 요약표

| 머지 방향 | 전략 | 브랜치 삭제 | 이유 |
|----------|------|------------|------|
| feature → develop | Squash and merge | ✅ 삭제 | 히스토리 정리 |
| bugfix → develop | Squash and merge | ✅ 삭제 | 히스토리 정리 |
| docs → develop | Squash and merge | ✅ 삭제 | 히스토리 정리 |
| develop → main | Merge commit | ❌ 유지 | 릴리스 이력 보존 |
| hotfix → main | Merge commit | ✅ 삭제 | 긴급 패치 반영 |

---

## PR 워크플로우

### PR 생성 규칙

**필수 요구사항:**
1. ✅ Base 브랜치: **develop** (hotfix만 main)
2. ✅ PR 제목: 커밋 메시지 규칙 준수
3. ✅ PR 본문: 템플릿 사용
4. ✅ 리뷰어: **popup-kay** (필수 승인)
5. ✅ 모든 체크 통과 (CI/CD)

### PR 제목 규칙

```
<type>: <subject>

예시:
feat: Add jira-rules-setup.sh script for cross-project setup
fix: Resolve permission error in setup.sh
docs: Update README with jira-rules-setup usage
```

### PR 본문 템플릿

```markdown
## Summary
<!-- 변경 사항 요약 (1-2 문장) -->

## Changes
<!-- 주요 변경 사항 목록 -->
- 변경 사항 1
- 변경 사항 2
- 변경 사항 3

## Checklist
- [ ] 기능이 정상 작동함
- [ ] 문서 업데이트 완료 (필요 시)
- [ ] 스크립트 실행 권한 확인 (해당 시)
- [ ] 기존 기능에 영향 없음

## Related Issues
<!-- 관련 이슈가 있다면 링크 -->
Closes #<이슈번호>

---
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### PR 리뷰 프로세스

```
1. PR 생성
   ↓
2. 자동 체크 (CI/CD)
   ↓
3. popup-kay 리뷰 요청 (자동)
   ↓
4. 코드 리뷰
   ├─ ✅ Approve → 5단계
   └─ ❌ Request changes → 수정 후 3단계
   ↓
5. popup-kay 승인 후 Squash and merge
   ↓
6. Feature 브랜치 자동 삭제
```

---

## GitHub 저장소 설정

### Branch Protection Rules

#### main 브랜치 보호 설정

```yaml
Branch name pattern: main

Protect matching branches:
  ✅ Require a pull request before merging
    ✅ Require approvals: 1
    ✅ Dismiss stale pull request approvals when new commits are pushed
    ✅ Require review from Code Owners

  ✅ Require status checks to pass before merging
    ✅ Require branches to be up to date before merging

  ✅ Require conversation resolution before merging

  ✅ Require linear history (Merge commit만 허용)

  ✅ Do not allow bypassing the above settings
    ⚠️ 예외: popup-kay (긴급 상황 대비)

  ✅ Restrict who can push to matching branches
    허용: popup-kay
```

#### develop 브랜치 보호 설정

```yaml
Branch name pattern: develop

Protect matching branches:
  ✅ Require a pull request before merging
    ✅ Require approvals: 1
    ✅ Dismiss stale pull request approvals when new commits are pushed
    ✅ Require review from Code Owners

  ✅ Require status checks to pass before merging

  ✅ Require conversation resolution before merging

  ✅ Do not allow bypassing the above settings

  ✅ Restrict who can push to matching branches
    허용: popup-kay, 핵심 기여자
```

### CODEOWNERS 파일

`.github/CODEOWNERS` 생성:

```
# AI-driven-work CODEOWNERS
# 모든 파일의 기본 소유자

* @popup-kay

# 특정 디렉토리 소유자 (필요 시)
/scripts/ @popup-kay
/.claude/ @popup-kay
/docs/ @popup-kay
```

### PR 기본 설정

**Settings → Pull Requests:**

```yaml
✅ Allow squash merging
  Default commit message: Pull request title

✅ Allow merge commits
  Default commit message: Pull request title and description

❌ Allow rebase merging (사용 안 함)

✅ Automatically delete head branches
```

### Issue 템플릿

`.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug Report
about: 버그 리포트
title: '[BUG] '
labels: bug
assignees: popup-kay
---

## 버그 설명
<!-- 버그에 대한 명확하고 간결한 설명 -->

## 재현 방법
1. '...'로 이동
2. '...' 클릭
3. '...' 스크롤
4. 에러 발생

## 예상 동작
<!-- 예상했던 정상 동작 설명 -->

## 실제 동작
<!-- 실제로 발생한 동작 설명 -->

## 환경
- OS: [예: macOS 14.0]
- Shell: [예: zsh 5.9]
- Node.js: [예: v20.10.0]

## 추가 정보
<!-- 스크린샷, 에러 로그 등 -->
```

`.github/ISSUE_TEMPLATE/feature_request.md`:

```markdown
---
name: Feature Request
about: 새로운 기능 제안
title: '[FEATURE] '
labels: enhancement
assignees: popup-kay
---

## 기능 설명
<!-- 제안하는 기능에 대한 명확한 설명 -->

## 문제 또는 필요성
<!-- 이 기능이 왜 필요한지 설명 -->

## 제안하는 해결 방법
<!-- 어떻게 구현되면 좋을지 설명 -->

## 대안
<!-- 고려한 다른 방법이 있다면 설명 -->

## 추가 정보
<!-- 참고 자료, 링크 등 -->
```

---

## 작업 흐름

### 1. 새 기능 개발 시작

```bash
# 1. develop 브랜치 최신화
git checkout develop
git pull origin develop

# 2. feature 브랜치 생성
git checkout -b feature/새기능명

# 3. 작업 및 커밋
# ... 작업 ...
git add .
git commit -m "feat: 기능 설명"

# 4. 추가 작업 및 커밋 (필요 시)
# ... 더 작업 ...
git commit -m "feat: 추가 작업"

# 5. 원격 저장소에 푸시
git push -u origin feature/새기능명
```

### 2. PR 생성

```bash
# GitHub 웹에서 PR 생성
# 또는 gh CLI 사용

gh pr create \
  --base develop \
  --title "feat: 새 기능 설명" \
  --body "$(cat <<'EOF'
## Summary
새 기능 추가

## Changes
- 변경 사항 1
- 변경 사항 2

## Checklist
- [x] 기능 정상 작동
- [x] 문서 업데이트
EOF
)"
```

### 3. 코드 리뷰 받기

```bash
# popup-kay의 리뷰 대기
# 수정 요청 시:

# 수정 작업
git add .
git commit -m "fix: 리뷰 피드백 반영"
git push origin feature/새기능명

# PR이 자동 업데이트됨
```

### 4. PR 머지 (popup-kay가 수행)

```bash
# GitHub 웹에서:
# 1. "Squash and merge" 선택
# 2. 커밋 메시지 확인/수정
# 3. Merge 실행
# 4. Feature 브랜치 자동 삭제 확인
```

### 5. 로컬 브랜치 정리

```bash
# develop 브랜치로 전환
git checkout develop

# develop 최신화
git pull origin develop

# 로컬 feature 브랜치 삭제
git branch -d feature/새기능명

# 원격에서 삭제된 브랜치 정리
git fetch --prune
```

### 6. 릴리스 (develop → main)

```bash
# popup-kay가 수행
# GitHub 웹에서:
# 1. develop → main PR 생성
# 2. 릴리스 노트 작성
# 3. "Create a merge commit" 선택
# 4. Merge 실행
# 5. Git tag 생성 (v1.0.0)
```

---

## 커밋 메시지 규칙

### 기본 형식

```
<type>: <subject>

<body> (선택사항)

<footer> (선택사항)
```

### Type 종류

| Type | 설명 | 예시 |
|------|------|------|
| **feat** | 새 기능 추가 | `feat: Add jira-rules-setup.sh script` |
| **fix** | 버그 수정 | `fix: Resolve permission error in setup.sh` |
| **docs** | 문서 개선 | `docs: Update README with setup guide` |
| **style** | 코드 포맷팅 (기능 변경 없음) | `style: Format code with prettier` |
| **refactor** | 코드 리팩토링 | `refactor: Simplify backup logic` |
| **test** | 테스트 추가/수정 | `test: Add unit tests for setup script` |
| **chore** | 빌드, 설정 등 | `chore: Update dependencies` |

### Subject 작성 규칙

```
✅ 좋은 예:
feat: Add jira-rules-setup.sh for cross-project integration
fix: Resolve dry-run mode file creation issue
docs: Add troubleshooting section to README

❌ 나쁜 예:
feat: add script (소문자 시작)
fix: fixed bug (과거형 사용)
docs: updated readme. (마침표 사용)
```

### Body 작성 (선택사항, 복잡한 변경 시 권장)

```
feat: Add jira-rules-setup.sh script for cross-project setup

- Create jira-rules-setup.sh to copy Jira features to other projects
- Copy slash commands (/daily-standup, /weekly-report, etc.)
- Copy jira-rules.md instructions
- Integrate with existing instructions via reference links
- Auto-backup before overwriting files
- Support dry-run mode for preview
- Handle file conflicts interactively

This enables users to add Jira slash commands and AI instructions
to any project, not just AI-driven-work, while maintaining project-
specific instructions through automatic integration.
```

---

## 코드 리뷰 가이드

### 리뷰어 (popup-kay) 체크리스트

**기능 관련:**
- [ ] 기능이 의도대로 작동하는가?
- [ ] 에러 처리가 적절한가?
- [ ] 엣지 케이스를 고려했는가?

**코드 품질:**
- [ ] 코드가 읽기 쉽고 명확한가?
- [ ] 중복 코드가 없는가?
- [ ] 네이밍이 명확한가?

**문서:**
- [ ] README 업데이트가 필요한가?
- [ ] 주석이 적절한가?
- [ ] 사용 예시가 충분한가?

**보안:**
- [ ] 민감한 정보가 노출되지 않는가?
- [ ] 파일 권한이 적절한가?
- [ ] 입력 검증이 충분한가?

### PR 작성자 체크리스트

**PR 생성 전:**
- [ ] develop 브랜치 기준으로 feature 브랜치 생성
- [ ] 커밋 메시지 규칙 준수
- [ ] 스크립트 실행 권한 확인 (`chmod +x`)
- [ ] 로컬 테스트 완료

**PR 본문 작성:**
- [ ] Summary 명확히 작성
- [ ] Changes 목록 작성
- [ ] Checklist 모두 체크
- [ ] Related Issues 연결 (해당 시)

**리뷰 대응:**
- [ ] 피드백을 정중하게 수용
- [ ] 수정 후 답변 남기기
- [ ] 논의가 필요하면 명확히 설명

---

## 긴급 상황 대응

### Hotfix 프로세스

```bash
# 1. main에서 hotfix 브랜치 생성
git checkout main
git pull origin main
git checkout -b hotfix/critical-issue

# 2. 긴급 수정
# ... 작업 ...
git add .
git commit -m "hotfix: Fix critical security vulnerability"

# 3. 푸시 및 PR 생성 (main으로)
git push -u origin hotfix/critical-issue
gh pr create --base main --title "hotfix: Critical security fix"

# 4. popup-kay 리뷰 및 승인

# 5. main에 Merge commit으로 머지
# GitHub 웹에서 "Create a merge commit" 선택

# 6. develop에 백포트
git checkout develop
git pull origin develop
git merge main
git push origin develop

# 7. hotfix 브랜치 삭제
git branch -d hotfix/critical-issue
git push origin --delete hotfix/critical-issue
```

---

## 자동화

### GitHub Actions (향후 추가)

```yaml
# .github/workflows/pr-checks.yml
name: PR Checks

on:
  pull_request:
    branches: [develop, main]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check script permissions
        run: |
          find scripts -name "*.sh" -type f ! -perm -u+x -print -quit | \
          grep -q . && echo "Error: Script missing execute permission" && exit 1 || \
          echo "All scripts have execute permission"

      - name: Validate markdown
        run: |
          npm install -g markdownlint-cli
          markdownlint '**/*.md' --ignore node_modules
```

---

## 요약: 절대 지켜야 할 규칙

1. ⭐ **모든 변경은 PR을 통해서만** - develop/main에 직접 push 절대 금지
2. ⭐ **popup-kay 승인 필수** - PR 머지는 반드시 리뷰 후
3. ⭐ **Squash and merge** (feature→develop) / **Merge commit** (develop→main)
4. ⭐ **Base 브랜치 확인** - PR 생성 시 develop 선택 (hotfix만 main)
5. ⭐ **커밋 메시지 규칙 준수** - `<type>: <subject>` 형식
6. ⭐ **Feature 브랜치 삭제** - 머지 후 자동 삭제 확인

---

**작성자**: 김경호 (popup-kay)
**최종 수정일**: 2025-11-08
**버전**: 1.0.0
