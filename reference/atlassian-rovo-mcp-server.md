# Atlassian Rovo MCP Server 조사 보고서

## 개요

Atlassian Rovo MCP Server는 Atlassian에서 직접 호스팅하고 관리하는 클라우드 기반 MCP(Model Context Protocol) 서버입니다. Jira, Confluence, Compass와 AI 도구(Claude Code 등)를 연결하는 브리지 역할을 합니다.

**공식 문서**: https://support.atlassian.com/atlassian-rovo-mcp-server/

**GitHub 저장소**: https://github.com/atlassian/atlassian-mcp-server

## 주요 특징

### 1. 클라우드 호스팅
- Atlassian이 서버를 직접 호스팅 및 관리
- 로컬 설치 및 유지보수 불필요
- 자동 업데이트 및 패치

### 2. OAuth 2.1 인증
- API 토큰 수동 관리 불필요
- 웹 브라우저를 통한 안전한 OAuth 인증 플로우
- 사용자의 기존 Atlassian 권한 존중
- TLS 1.2 이상 HTTPS 암호화

### 3. 베타 서비스
- 현재 무료 베타 단계
- 모든 Atlassian Cloud 고객 사용 가능
- 별도 가입 절차 불필요

## 비용

### 현재 (베타 단계)
**무료**로 제공됩니다.

### 사용량 제한
- **Standard 플랜**: 중간 수준의 사용 임계값
- **Premium/Enterprise 플랜**:
  - 시간당 1,000개 요청
  - 사용자별 추가 제한

### 향후 가격 정책
베타 종료 후 가격 정책은 아직 공개되지 않았습니다.

## 지원 플랫폼

### AI 클라이언트
- Claude Desktop
- Claude for Teams
- **Claude Code** ✅
- 기타 MCP 호환 클라이언트

### Atlassian 제품
- Jira (이슈 관리)
- Confluence (문서)
- Compass (개발자 경험 플랫폼)

## Claude Code 설정 방법

### 방법 1: SSE (Server-Sent Events) 방식 ⭐ 권장

**가장 간단한 방법**입니다.

#### 사용자 전역 설정 (모든 프로젝트에서 사용)
```bash
claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse
```

#### 프로젝트별 설정 (팀 협업용)
```bash
cd your-project
claude mcp add --transport sse --scope local atlassian https://mcp.atlassian.com/v1/sse
```

이 명령은 프로젝트 루트에 `.mcp.json` 파일을 생성하며, 버전 관리(Git)에 커밋하여 팀원들과 공유할 수 있습니다.

#### 생성되는 설정 파일 형식
```json
{
  "mcpServers": {
    "atlassian": {
      "type": "sse",
      "url": "https://mcp.atlassian.com/v1/sse"
    }
  }
}
```

### 방법 2: mcp-remote 프록시 방식

Node.js 기반 프록시를 사용하는 방법입니다.

#### 사전 요구사항
- Node.js v18 이상
- npx 사용 가능

#### 설정 단계

**1. MCP 설정 파일 수정**

`~/.config/claude/mcp/claude_desktop_config.json` 파일에 추가:

```json
{
  "mcpServers": {
    "atlassian": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.atlassian.com/v1/sse"]
    }
  }
}
```

**2. 버전 호환성 문제 발생 시**

특정 버전 지정:
```json
{
  "mcpServers": {
    "atlassian": {
      "command": "npx",
      "args": ["-y", "mcp-remote@0.1.13", "https://mcp.atlassian.com/v1/sse"]
    }
  }
}
```

**3. 터미널에서 직접 실행하는 방법**
```bash
npx -y mcp-remote https://mcp.atlassian.com/v1/sse
```

## 인증 절차

### 최초 연결 시

1. Claude Code 실행
2. "Connect Atlassian Account" 메시지 표시
3. 웹 브라우저 자동 실행
4. Atlassian 계정으로 로그인
5. 접근 권한 승인:
   - Jira 접근
   - Confluence 접근
   - Compass 접근 (선택)
6. 인증 완료

### 재인증

일정 시간 비활성 후 재인증이 필요할 수 있습니다 (알려진 베타 이슈).

## 사용 예시

### Jira 작업

#### 이슈 검색
```
"Project Alpha의 모든 미해결 버그 찾아줘"
"Find all open bugs in Project Alpha"
```

#### 이슈 생성
```
"'온보딩 재설계'라는 제목의 Story 생성해줘"
"Create a story titled 'Redesign onboarding'"
```

#### 이슈 업데이트
```
"PROJ-123 이슈를 Done으로 변경해줘"
"Update PROJ-123 status to Done"
```

#### 대량 이슈 생성
```
"이 메모에서 Jira 이슈 5개 만들어줘"
"Create 5 Jira issues from these notes"
```

### Confluence 작업

#### 페이지 요약
```
"Q2 기획 페이지를 요약해줘"
"Summarize the Q2 planning page"
```

#### 페이지 생성
```
"'Q3 팀 목표'라는 제목의 페이지 만들어줘"
"Create a page titled 'Team Goals Q3'"
```

#### 페이지 검색
```
"배포 프로세스 관련 문서를 찾아줘"
"Find all documentation about deployment process"
```

### 통합 작업

```
"PROJ-100 이슈의 내용을 Confluence에 기술 문서로 작성해줘"
"Create technical documentation in Confluence from PROJ-100"

"이번 주 완료한 이슈들을 Confluence 주간 보고서에 정리해줘"
"Add this week's completed issues to the Confluence weekly report"
```

## 기존 mcp-atlassian과 비교

### Atlassian Rovo MCP Server (클라우드)

#### 장점 ✅
- **간편한 설정**: 한 줄 명령으로 설치 완료
- **OAuth 인증**: API 토큰 수동 관리 불필요
- **자동 업데이트**: Atlassian이 서버 유지보수
- **보안 강화**: OAuth 2.1, TLS 1.2+ 암호화
- **무료 (베타)**: 현재 비용 없음
- **접근 권한 존중**: 사용자의 Jira/Confluence 권한 그대로 적용
- **팀 협업**: `.mcp.json` 파일 공유로 팀 설정 동기화

#### 단점 ⚠️
- **인터넷 필수**: 클라우드 의존
- **사용량 제한**: 시간당 요청 수 제한
- **베타 안정성**: 간헐적 재인증 필요 (알려진 이슈)
- **향후 유료화 가능성**: 베타 종료 후 가격 정책 미정
- **제한된 제어**: Atlassian 정책에 의존

### mcp-atlassian (로컬)

#### 장점 ✅
- **오프라인 가능**: 로컬 환경에서 실행
- **사용량 무제한**: API 제한만 적용
- **완전한 제어**: 모든 설정 직접 관리
- **안정적**: 로컬 실행으로 외부 서비스 장애 영향 없음
- **가격 확정**: 무료 오픈소스

#### 단점 ⚠️
- **복잡한 설정**: API 토큰 발급 및 설정 필요
- **수동 업데이트**: 직접 버전 관리 필요
- **보안 관리**: API 토큰 로컬 저장 및 관리
- **설치 필수**: npm/npx 설치 및 실행 필요

### 비교 표

| 항목 | Rovo MCP Server (클라우드) | mcp-atlassian (로컬) |
|------|---------------------------|---------------------|
| **설치** | `claude mcp add` 한 줄 | npm 설치 + 설정 파일 작성 |
| **인증** | OAuth (브라우저) | API 토큰 (수동 발급) |
| **호스팅** | Atlassian 클라우드 | 로컬 환경 |
| **업데이트** | 자동 | 수동 |
| **인터넷** | 필수 | 선택 (API 호출 시만) |
| **사용량 제한** | 시간당 1,000개 (Premium) | API 제한만 |
| **비용** | 무료 (베타, 향후 미정) | 무료 (오픈소스) |
| **보안** | OAuth + TLS 1.2+ | API 토큰 |
| **팀 공유** | `.mcp.json` 공유 | 설정 파일 공유 |
| **안정성** | 베타 (재인증 이슈) | 안정적 |

## 알려진 이슈

### 재인증 문제
- **증상**: 일정 시간 비활성 후 "Connect Atlassian Account" 메시지 재표시
- **원인**: SSE 연결 안정성 문제 (베타 단계)
- **해결**: 브라우저에서 재인증

### 호환성
- **Node.js**: v18 이상 필수
- **브라우저**: OAuth 인증을 위한 모던 브라우저 필요

### 사용량 초과
- **증상**: "Rate limit exceeded" 오류
- **해결**:
  - Premium/Enterprise 플랜 업그레이드
  - 요청 빈도 조절
  - 다음 시간까지 대기

## 보안 고려사항

### 암호화
- 모든 통신은 TLS 1.2 이상의 HTTPS로 암호화
- 중간자 공격(MITM) 방지

### 권한 관리
- OAuth 2.1 표준 준수
- 사용자의 Atlassian 권한 그대로 적용
- 접근 가능한 프로젝트/페이지만 조회 가능

### 데이터 저장
- 인증 토큰은 Atlassian 서버에서 관리
- 로컬에는 OAuth 세션 정보만 저장

## 권장 사항

### Rovo MCP Server를 추천하는 경우
- ✅ 일반적인 업무 사용
- ✅ 간편한 설정 선호
- ✅ 팀 협업 환경
- ✅ OAuth 인증 선호
- ✅ 자동 업데이트 선호

### mcp-atlassian을 추천하는 경우
- ✅ 오프라인 작업 필요
- ✅ 사용량이 매우 많음 (시간당 1,000개 이상)
- ✅ 완전한 제어 필요
- ✅ 보안 정책상 외부 서비스 사용 제한
- ✅ 안정성이 최우선

### 우리 회사(DubDubDub Corp.) 권장 사항

**Atlassian Rovo MCP Server를 기본으로 사용**하되, 다음 상황에서는 mcp-atlassian 병행:

1. **개발 환경**: Rovo MCP Server (간편함)
2. **CI/CD 파이프라인**: mcp-atlassian (안정성)
3. **대량 데이터 처리**: mcp-atlassian (사용량 제한 없음)
4. **일반 업무**: Rovo MCP Server (OAuth 편의성)

## 마이그레이션 가이드

### mcp-atlassian → Rovo MCP Server

#### 1. 기존 설정 백업
```bash
cp ~/.config/claude/mcp/claude_desktop_config.json ~/.config/claude/mcp/claude_desktop_config.json.backup
```

#### 2. Rovo MCP Server 추가
```bash
claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse
```

#### 3. 기존 mcp-atlassian 설정 제거
`~/.config/claude/mcp/claude_desktop_config.json`에서 기존 atlassian 항목 삭제:

```json
// 삭제할 부분
{
  "mcpServers": {
    "atlassian": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-atlassian"],
      "env": {
        "ATLASSIAN_URL": "...",
        "ATLASSIAN_EMAIL": "...",
        "ATLASSIAN_API_TOKEN": "..."
      }
    }
  }
}
```

#### 4. Claude Code 재시작 및 인증
```bash
# Claude Code 재시작
# OAuth 인증 진행
```

#### 5. 동작 확인
```
"Jira에서 미할당 이슈 찾아줘"
```

### 롤백 방법

문제 발생 시 백업된 설정으로 복원:
```bash
cp ~/.config/claude/mcp/claude_desktop_config.json.backup ~/.config/claude/mcp/claude_desktop_config.json
```

## 문제 해결

### "Connect Atlassian Account" 반복 표시
**원인**: OAuth 세션 만료
**해결**:
1. 브라우저에서 재인증
2. 문제 지속 시 mcp-atlassian 사용 고려

### "Rate limit exceeded" 오류
**원인**: 사용량 제한 초과
**해결**:
1. 요청 빈도 줄이기
2. Premium/Enterprise 플랜 확인
3. 대량 작업은 mcp-atlassian 사용

### 연결 실패
**원인**: 네트워크 문제 또는 Atlassian 서비스 장애
**해결**:
1. 인터넷 연결 확인
2. https://status.atlassian.com/ 에서 서비스 상태 확인
3. VPN 사용 시 비활성화 시도

### Node.js 버전 오류
**원인**: Node.js v18 미만 사용
**해결**:
```bash
# 버전 확인
node --version

# v18 이상으로 업그레이드
# nvm 사용 시
nvm install 18
nvm use 18
```

## 추가 리소스

### 공식 문서
- [Getting Started](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/getting-started-with-the-atlassian-remote-mcp-server/)
- [Setting up IDEs](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/setting-up-ides/)
- [Authentication Guide](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/understanding-authentication-oauth/)
- [Usage Guide](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/use-atlassian-rovo-mcp-server/)

### GitHub
- [atlassian/atlassian-mcp-server](https://github.com/atlassian/atlassian-mcp-server)

### 커뮤니티
- [Atlassian Community - Jira Questions](https://community.atlassian.com/forums/Jira-questions)
- [Atlassian Support Portal](https://support.atlassian.com/)

## 결론

Atlassian Rovo MCP Server는 **설정의 간편함**과 **OAuth 보안**을 제공하며, 현재 **무료 베타** 단계입니다.

**일반적인 업무 환경**에서는 Rovo MCP Server를 **기본 권장**하며, **특수한 요구사항**(오프라인, 대량 처리, 완전 제어)이 있는 경우에만 기존 mcp-atlassian 사용을 고려하는 것이 좋습니다.

---

**작성일**: 2025-11-06
**작성자**: Claude Code
**버전**: 1.0
**상태**: Atlassian Rovo MCP Server 베타 기준
