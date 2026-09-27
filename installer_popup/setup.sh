#!/bin/bash

# DubDubDub Corp. MCP Setup Script
# Usage: chmod +x setup.sh && ./setup.sh

set -e

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
echo "=========================================="
echo -e "${BLUE}🚀 DubDubDub Corp. AI-Driven Work${NC}"
echo "=========================================="
echo ""
echo "이 스크립트는 Claude Code와 Atlassian MCP Server를 설정합니다."
echo ""

# 직군 확인 (권장 사항 제시용)
echo -e "${CYAN}📋 먼저 몇 가지 질문에 답해주세요:${NC}"
echo ""
echo "1. 개발자 (백엔드/프론트엔드/DevOps/QA)"
echo "2. 비개발자 (기획/디자인/마케팅/운영)"
echo ""
read -p "직군을 선택하세요 (1 또는 2): " JOB_TYPE
echo ""

# ============================================================
# 1단계: Node.js 확인
# ============================================================
echo "=========================================="
echo -e "${BLUE}📦 1단계: Node.js 확인${NC}"
echo "=========================================="
echo ""

if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js가 설치되어 있지 않습니다.${NC}"
    echo ""
    echo "Node.js를 설치해주세요:"
    echo "  https://nodejs.org/"
    echo ""
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}❌ Node.js 버전이 18 미만입니다. (현재: $(node --version))${NC}"
    echo "Node.js 18 이상을 설치해주세요."
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ Node.js $(node --version) 확인됨${NC}"
echo ""

# ============================================================
# 2단계: Claude Code 설치
# ============================================================
echo "=========================================="
echo -e "${BLUE}🤖 2단계: Claude Code 설치${NC}"
echo "=========================================="
echo ""

if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}⚠️  Claude Code가 설치되어 있지 않습니다.${NC}"
    echo ""
    read -p "Claude Code를 설치하시겠습니까? (y/n): " INSTALL_CLAUDE

    if [[ "$INSTALL_CLAUDE" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo ""
        echo "Claude Code 설치 중..."
        npm install -g @anthropic-ai/claude-code
        echo ""
        echo -e "${GREEN}✅ Claude Code 설치 완료${NC}"
    else
        echo ""
        echo -e "${RED}❌ Claude Code는 필수입니다. 설치를 취소합니다.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ Claude Code 설치 확인됨${NC}"
fi
echo ""

# ============================================================
# 3단계: Claude Code 설정 디렉토리 생성
# ============================================================
echo "=========================================="
echo -e "${BLUE}📁 3단계: 설정 디렉토리 생성${NC}"
echo "=========================================="
echo ""

CLAUDE_CONFIG_DIR="$HOME/.config/claude"
CLAUDE_MCP_DIR="$CLAUDE_CONFIG_DIR"

mkdir -p "$CLAUDE_CONFIG_DIR"
mkdir -p "$CLAUDE_MCP_DIR"

echo -e "${GREEN}✅ 설정 디렉토리 생성 완료${NC}"
echo "   $CLAUDE_CONFIG_DIR"
echo "   $CLAUDE_MCP_DIR"
echo ""

# ============================================================
# 4단계: Slash Commands 복사
# ============================================================
echo "=========================================="
echo -e "${BLUE}⚡ 4단계: Slash Commands 복사${NC}"
echo "=========================================="
echo ""

CLAUDE_COMMANDS_DIR="$CLAUDE_CONFIG_DIR/.claude/commands"
mkdir -p "$CLAUDE_COMMANDS_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

if [ -d "$PROJECT_DIR/.claude/commands" ]; then
    cp -r "$PROJECT_DIR/.claude/commands/"* "$CLAUDE_COMMANDS_DIR/"
    echo -e "${GREEN}✅ Slash commands 복사 완료${NC}"
    echo "   - /daily-standup"
    echo "   - /weekly-report"
    echo "   - /assign-me"
    echo "   - /save-slack-thread"
else
    echo -e "${YELLOW}⚠️  Slash commands 디렉토리를 찾을 수 없습니다.${NC}"
fi
echo ""

# ============================================================
# 5단계: MCP Server 선택
# ============================================================
echo "=========================================="
echo -e "${BLUE}🔧 5단계: MCP Server 선택${NC}"
echo "=========================================="
echo ""

# 직군별 권장 사항 표시
if [ "$JOB_TYPE" = "1" ]; then
    echo -e "${CYAN}💡 개발자에게 권장: mcp-atlassian${NC}"
    echo "   - 16개 전체 도구"
    echo "   - 사용량 무제한"
    echo "   - 완전한 제어"
    echo "   - CI/CD 통합 가능"
    echo ""
else
    echo -e "${CYAN}💡 비개발자에게 권장: Rovo MCP Server${NC}"
    echo "   - 설정이 매우 간단 (2분)"
    echo "   - OAuth 인증"
    echo "   - 자동 업데이트"
    echo ""
fi

echo "사용할 MCP Server를 선택하세요:"
echo ""
echo "1. Rovo MCP Server (클라우드 기반, 간편 설정)"
echo "   - 설정 시간: 2분"
echo "   - 인증: OAuth (브라우저 클릭)"
echo "   - 비용: 무료 (베타)"
echo "   - 권장: 비개발자, 일반 업무"
echo ""
echo "2. mcp-atlassian (로컬 Docker 기반, 고급 기능)"
echo "   - 설정 시간: 15분"
echo "   - 인증: API 토큰"
echo "   - 비용: 무료 (영구)"
echo "   - 권장: 개발자, 대량 작업, CI/CD"
echo ""
read -p "선택하세요 (1 또는 2): " MCP_CHOICE
echo ""

# ============================================================
# 6단계: 선택한 MCP Server 설정
# ============================================================

if [ "$MCP_CHOICE" = "1" ]; then
    # ========================================================
    # Rovo MCP Server 설정
    # ========================================================
    echo "=========================================="
    echo -e "${BLUE}🌐 Rovo MCP Server 설정${NC}"
    echo "=========================================="
    echo ""

    echo "Rovo MCP Server를 설정합니다..."
    echo ""

    echo -e "${CYAN}다음 명령어를 실행합니다:${NC}"
    echo "  claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse"
    echo ""

    # claude mcp add 명령어 실행
    if claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse; then
        echo ""
        echo -e "${GREEN}✅ Rovo MCP Server 설정 완료${NC}"
        echo ""
        echo "=========================================="
        echo -e "${GREEN}✨ 환경 설정이 완료되었습니다! ✨${NC}"
        echo "=========================================="
        echo ""
        echo -e "${YELLOW}📝 다음 단계:${NC}"
        echo ""
        echo "1. Claude Code 실행:"
        echo -e "   ${CYAN}claude${NC}"
        echo ""
        echo "2. OAuth 인증:"
        echo "   - 브라우저가 자동으로 열립니다"
        echo "   - Atlassian 계정으로 로그인"
        echo "   - 'Allow' 버튼 클릭"
        echo ""
        echo "3. 연결 테스트:"
        echo -e "   ${CYAN}Jira에서 사용 가능한 프로젝트 보여줘${NC}"
        echo ""
        echo "4. 첫 slash command 실행:"
        echo -e "   ${CYAN}/daily-standup${NC}"
        echo ""
    else
        echo ""
        echo -e "${RED}❌ Rovo MCP Server 설정에 실패했습니다.${NC}"
        echo ""
        echo "수동 설정 방법:"
        echo "  claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse"
        echo ""
        exit 1
    fi

elif [ "$MCP_CHOICE" = "2" ]; then
    # ========================================================
    # mcp-atlassian 설정
    # ========================================================
    echo "=========================================="
    echo -e "${BLUE}🐳 mcp-atlassian 설정${NC}"
    echo "=========================================="
    echo ""

    # Docker 확인
    echo "Docker 설치 확인 중..."
    echo ""

    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker가 설치되어 있지 않습니다.${NC}"
        echo ""
        echo "Docker를 먼저 설치해주세요:"
        echo "  Mac: https://docs.docker.com/desktop/install/mac-install/"
        echo "  Windows: https://docs.docker.com/desktop/install/windows-install/"
        echo ""
        echo "설치 후 다시 이 스크립트를 실행해주세요."
        echo ""
        exit 1
    fi

    echo -e "${GREEN}✅ Docker 설치 확인됨${NC}"
    echo ""

    # Docker 이미지 다운로드
    echo "Docker 이미지 다운로드 중..."
    echo ""

    if docker pull ghcr.io/sooperset/mcp-atlassian:latest; then
        echo ""
        echo -e "${GREEN}✅ Docker 이미지 다운로드 완료${NC}"
        echo ""
    else
        echo ""
        echo -e "${RED}❌ Docker 이미지 다운로드 실패${NC}"
        echo ""
        echo "수동으로 다운로드해주세요:"
        echo "  docker pull ghcr.io/sooperset/mcp-atlassian:latest"
        echo ""
        exit 1
    fi

    # 기존 설정 확인
    MCP_ATLASSIAN_DIR="$HOME/.mcp-atlassian"
    ENV_FILE="$MCP_ATLASSIAN_DIR/.env"
    USE_EXISTING_CONFIG="false"

    if [ -f "$ENV_FILE" ]; then
        # 기존 설정 파일이 존재하는 경우
        echo "=========================================="
        echo -e "${CYAN}📋 기존 설정 발견${NC}"
        echo "=========================================="
        echo ""

        # 기존 이메일 정보 읽기
        EXISTING_JIRA_EMAIL=$(grep "^JIRA_USERNAME=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2)
        EXISTING_CONFLUENCE_EMAIL=$(grep "^CONFLUENCE_USERNAME=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2)

        if [ -n "$EXISTING_JIRA_EMAIL" ] || [ -n "$EXISTING_CONFLUENCE_EMAIL" ]; then
            echo "기존 설정 정보:"
            [ -n "$EXISTING_JIRA_EMAIL" ] && echo -e "  Jira 이메일: ${CYAN}$EXISTING_JIRA_EMAIL${NC}"
            [ -n "$EXISTING_CONFLUENCE_EMAIL" ] && echo -e "  Confluence 이메일: ${CYAN}$EXISTING_CONFLUENCE_EMAIL${NC}"
            echo ""
            echo "1. 기존 설정 사용 (빠른 재설정)"
            echo "2. 새로 입력 (계정 변경 또는 재설정)"
            echo ""
            read -p "선택하세요 (1 또는 2, 기본값: 1): " CONFIG_CHOICE
            echo ""

            if [ "$CONFIG_CHOICE" != "2" ]; then
                USE_EXISTING_CONFIG="true"
                echo -e "${GREEN}✅ 기존 설정을 사용합니다${NC}"
                echo ""

                # .env 파일에서 값 읽기
                CONFLUENCE_URL=$(grep "^CONFLUENCE_URL=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                CONFLUENCE_USERNAME=$(grep "^CONFLUENCE_USERNAME=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                CONFLUENCE_API_TOKEN=$(grep "^CONFLUENCE_API_TOKEN=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                JIRA_URL=$(grep "^JIRA_URL=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                JIRA_USERNAME=$(grep "^JIRA_USERNAME=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                JIRA_API_TOKEN=$(grep "^JIRA_API_TOKEN=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                JIRA_PROJECTS_FILTER=$(grep "^JIRA_PROJECTS_FILTER=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                CONFLUENCE_SPACES_FILTER=$(grep "^CONFLUENCE_SPACES_FILTER=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
                READ_ONLY_MODE=$(grep "^READ_ONLY_MODE=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2-)
            fi
        fi
    fi

    # 새로 입력받기
    if [ "$USE_EXISTING_CONFIG" = "false" ]; then
        # API 토큰 발급 안내
        echo "=========================================="
        echo -e "${YELLOW}📝 Atlassian API 토큰 발급${NC}"
        echo "=========================================="
        echo ""
        echo "1. 다음 URL에 접속하세요:"
        echo -e "   ${CYAN}https://id.atlassian.com/manage-profile/security/api-tokens${NC}"
        echo ""
        echo "2. 'Create API token' 클릭"
        echo ""
        echo "3. 토큰 이름 입력 (예: MCP-ATLASSIAN)"
        echo ""
        echo "4. 생성된 토큰 복사 (다시 볼 수 없으니 안전하게 보관)"
        echo ""
        read -p "API 토큰을 발급받았으면 Enter를 누르세요..."
        echo ""

        # Atlassian 정보 입력
        echo "=========================================="
        echo -e "${YELLOW}🔑 Atlassian 정보 입력${NC}"
        echo "=========================================="
        echo ""

        read -p "Confluence URL (예: https://popupstudio.atlassian.net/wiki): " CONFLUENCE_URL
        read -p "Confluence 사용자 이메일: " CONFLUENCE_USERNAME
        read -p "Confluence API 토큰: " CONFLUENCE_API_TOKEN
        echo ""
        echo ""

        read -p "Jira URL (예: https://popupstudio.atlassian.net): " JIRA_URL
        read -p "Jira 사용자 이메일: " JIRA_USERNAME
        read -p "Jira API 토큰: " JIRA_API_TOKEN
        echo ""
        echo ""

        # 선택적 필터링 설정
        echo "=========================================="
        echo -e "${YELLOW}⚙️  선택적 설정 (Enter만 누르면 스킵)${NC}"
        echo "=========================================="
        echo ""

        read -p "Jira 프로젝트 필터 (쉼표로 구분, 예: PROJ,DEV): " JIRA_PROJECTS_FILTER
        read -p "Confluence 스페이스 필터 (쉼표로 구분, 예: POPUP,DEV): " CONFLUENCE_SPACES_FILTER
        echo ""

        read -p "읽기 전용 모드 사용? (y/n, 권장: n): " READ_ONLY_MODE
        if [[ "$READ_ONLY_MODE" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            READ_ONLY_MODE="true"
        else
            READ_ONLY_MODE=""
        fi
        echo ""
    fi

    # .env 파일 생성
    echo "환경 변수 파일 생성 중..."
    echo ""

    mkdir -p "$MCP_ATLASSIAN_DIR"

    cat > "$ENV_FILE" <<EOF
# Confluence 설정
CONFLUENCE_URL=$CONFLUENCE_URL
CONFLUENCE_USERNAME=$CONFLUENCE_USERNAME
CONFLUENCE_API_TOKEN=$CONFLUENCE_API_TOKEN

# Jira 설정
JIRA_URL=$JIRA_URL
JIRA_USERNAME=$JIRA_USERNAME
JIRA_API_TOKEN=$JIRA_API_TOKEN
EOF

    # 선택적 설정 추가
    if [ -n "$JIRA_PROJECTS_FILTER" ]; then
        echo "" >> "$ENV_FILE"
        echo "# 프로젝트 필터링" >> "$ENV_FILE"
        echo "JIRA_PROJECTS_FILTER=$JIRA_PROJECTS_FILTER" >> "$ENV_FILE"
    fi

    if [ -n "$CONFLUENCE_SPACES_FILTER" ]; then
        if [ -z "$JIRA_PROJECTS_FILTER" ]; then
            echo "" >> "$ENV_FILE"
            echo "# 스페이스 필터링" >> "$ENV_FILE"
        fi
        echo "CONFLUENCE_SPACES_FILTER=$CONFLUENCE_SPACES_FILTER" >> "$ENV_FILE"
    fi

    if [ -n "$READ_ONLY_MODE" ]; then
        echo "" >> "$ENV_FILE"
        echo "# 읽기 전용 모드" >> "$ENV_FILE"
        echo "READ_ONLY_MODE=$READ_ONLY_MODE" >> "$ENV_FILE"
    fi

    # 파일 권한 설정
    chmod 600 "$ENV_FILE"

    echo -e "${GREEN}✅ 환경 변수 파일 생성 완료${NC}"
    echo "   $ENV_FILE"
    echo ""

    # Claude Desktop App 설정 파일 생성
    echo "Claude Desktop App 설정 파일 생성 중..."
    echo ""

    MCP_CONFIG_FILE="$CLAUDE_MCP_DIR/claude_desktop_config.json"

    cat > "$MCP_CONFIG_FILE" <<EOF
{
  "mcpServers": {
    "mcp-atlassian": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "--env-file", "$ENV_FILE",
        "ghcr.io/sooperset/mcp-atlassian:latest"
      ]
    }
  }
}
EOF

    # 파일 권한 설정
    chmod 600 "$MCP_CONFIG_FILE"

    echo -e "${GREEN}✅ Claude Desktop App 설정 완료${NC}"
    echo "   $MCP_CONFIG_FILE"
    echo ""

    # Claude Code CLI 설정 추가
    echo "Claude Code CLI 설정 중..."
    echo ""

    if command -v claude &> /dev/null; then
        # MCP 서버 사용 범위 선택
        echo "=========================================="
        echo -e "${YELLOW}🔧 MCP 서버 사용 범위 선택${NC}"
        echo "=========================================="
        echo ""
        echo "1. 모든 프로젝트에서 사용 (권장)"
        echo "   - 어떤 프로젝트에서든 Jira/Confluence 접근 가능"
        echo "   - 한 번 설정으로 모든 곳에서 사용"
        echo ""
        echo "2. 이 프로젝트에서만 사용"
        echo "   - 현재 프로젝트(AI-driven-work)에서만 사용"
        echo "   - 다른 프로젝트에서는 설정 불필요"
        echo ""
        read -p "선택하세요 (1 또는 2, 기본값: 1): " MCP_SCOPE_CHOICE
        echo ""

        # scope 설정
        if [ "$MCP_SCOPE_CHOICE" = "2" ]; then
            MCP_SCOPE="local"
            SCOPE_DESC="이 프로젝트에서만"
        else
            MCP_SCOPE="user"
            SCOPE_DESC="모든 프로젝트에서"
        fi

        echo -e "선택된 범위: ${CYAN}$SCOPE_DESC 사용${NC}"
        echo ""

        # 기존 mcp-atlassian 설정 제거 (있다면)
        claude mcp remove mcp-atlassian &> /dev/null || true

        # Claude Code CLI에 MCP 서버 추가
        if claude mcp add --scope "$MCP_SCOPE" --transport stdio mcp-atlassian -- docker run -i --rm --env-file "$ENV_FILE" ghcr.io/sooperset/mcp-atlassian:latest; then
            echo -e "${GREEN}✅ Claude Code CLI 설정 완료 (scope: $MCP_SCOPE)${NC}"
            echo ""

            # 연결 테스트
            echo "연결 테스트 중..."
            if claude mcp list | grep -q "mcp-atlassian.*Connected"; then
                echo -e "${GREEN}✅ MCP 서버 연결 성공!${NC}"
            else
                echo -e "${YELLOW}⚠️  MCP 서버 연결을 확인할 수 없습니다. Claude Code 재시작 후 테스트해주세요.${NC}"
            fi
            echo ""
        else
            echo -e "${RED}❌ Claude Code CLI 설정 실패${NC}"
            echo ""
            echo "수동으로 설정하려면 다음 명령을 실행하세요:"
            echo -e "  ${CYAN}claude mcp add --scope $MCP_SCOPE --transport stdio mcp-atlassian -- docker run -i --rm --env-file $ENV_FILE ghcr.io/sooperset/mcp-atlassian:latest${NC}"
            echo ""
        fi
    else
        echo -e "${YELLOW}⚠️  Claude Code CLI가 설치되지 않았습니다.${NC}"
        echo "Claude Desktop App 설정만 완료되었습니다."
        echo ""
    fi

    echo "=========================================="
    echo -e "${GREEN}✨ 환경 설정이 완료되었습니다! ✨${NC}"
    echo "=========================================="
    echo ""
    echo -e "${YELLOW}📝 다음 단계:${NC}"
    echo ""
    echo "1. Claude Code 실행:"
    echo -e "   ${CYAN}claude${NC}"
    echo ""
    echo "2. 연결 테스트:"
    echo -e "   ${CYAN}Jira 프로젝트 목록 보여줘${NC}"
    echo ""
    echo "3. 첫 slash command 실행:"
    echo -e "   ${CYAN}/daily-standup${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  보안 알림:${NC}"
    echo "   API 토큰은 절대 공유하지 마세요!"
    echo "   $ENV_FILE 파일 권한: 600 (본인만 읽기 가능)"
    echo ""

else
    echo -e "${RED}❌ 잘못된 선택입니다. (1 또는 2를 입력하세요)${NC}"
    exit 1
fi

# ============================================================
# 문서 안내
# ============================================================
echo "=========================================="
echo -e "${CYAN}📚 참고 문서${NC}"
echo "=========================================="
echo ""

if [ "$MCP_CHOICE" = "1" ]; then
    echo "Rovo MCP Server 상세 정보:"
    echo "  $PROJECT_DIR/reference/atlassian-rovo-mcp-server.md"
else
    echo "mcp-atlassian 상세 정보:"
    echo "  $PROJECT_DIR/reference/mcp-atlassian.md"
fi

echo ""
echo "MCP Server 선택 가이드:"
echo "  $PROJECT_DIR/docs/mcp-server-selection-guide.md"
echo ""
echo "Claude Code 사용 가이드:"
echo "  $PROJECT_DIR/docs/claude-code-guide.md"
echo ""
echo "Jira 운영 규칙:"
echo "  $PROJECT_DIR/docs/jira-guidelines.md"
echo ""
echo "Confluence 운영 규칙:"
echo "  $PROJECT_DIR/docs/confluence-guidelines.md"
echo ""

echo "=========================================="
echo -e "${GREEN}🎉 설정 완료! 즐거운 작업 되세요! 🎉${NC}"
echo "=========================================="
echo ""
