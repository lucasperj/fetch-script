#!/bin/bash

print_usage_manual() {
    echo "Usage: $0"
    echo "Options:"
    echo "  -r <repository>   Set repository name"
    echo "  -i <gitid>        Set git ID"
    echo "  -b <branch>       Set branch name"
    echo "  -m                Set rebase flag to match your branch with master"
    echo "  -t <file#name>    Set testFile#testName - [If you want to run a test]"
    echo "  -a                Set ant-all flag if you want to build on top of the new branch"
    echo "  -h                See usage instructions"
    echo "  
Usage example: $0 -r liferay-uniform -i 1272 -b LPS-185851 -m -t PortalSmokeUpgrade#ViewPortalSmokeArchive625 -a"
}

while getopts "ar:mi:b:t:h" opt; do
    case $opt in
        a) BUILD_FLAG=true;;
        r) GIT_REPO="${OPTARG}";;
        m) REBASE_FLAG=true;;
        i) GIT_ID="${OPTARG}";;
        b) GIT_BRANCH_NAME="${OPTARG}";;
        t) TEST_FILE="${OPTARG}";;
        h) print_usage_manual; exit 0;;
        *) echo "Invalid command. Run [$0 -h] for more details." >&2; exit 1;;
    esac
done

# ANSI escape sequences
YELLOW_BOLD="\033[1;33m"
RED_BOLD="\033[1;31m"
GREEN_BOLD="\033[1;32m"
RESET="\033[0m"

if [ -n "$TEST_FILE" ]; then
    echo -e "${YELLOW_BOLD}If you are running an upgrade test, make sure to set the file path for the legacy repo in your test.USERNAME.properties.${RESET}"
    echo -e "${RED_BOLD}Note that the script is using run-selenium-tomcat-mysql 5.7 version.${RESET}
"

    # Confirmation question
    read -p "Do you want to proceed with the test? (Y/N): " confirm
    if [[ "${confirm}" == [yY] || "${confirm}" == [yY][sS] ]]; then
        echo -e "${GREEN_BOLD}Running.${RESET}"
    else
        echo "Operation canceled by the user."
        exit 0
    fi
fi

cd ../liferay-portal

git fetch https://github.com/"${GIT_REPO}"/liferay-portal/ pull/"${GIT_ID}"/head:"${GIT_BRANCH_NAME}"
git checkout "${GIT_BRANCH_NAME}"

if [ "${REBASE_FLAG}" = true ]; then
    git rebase master
fi

if [ "${BUILD_FLAG}" = true ]; then
    ant all
fi

if [ -n "${TEST_FILE}" ]; then
    echo -e "${YELLOW_BOLD}Executing:${RESET} ${TEST_FILE}"
    
    ant -f build-test-tomcat-mysql.xml run-selenium-tomcat-mysql -Ddatabase.version=5.7 -Dtest.class="${TEST_FILE}"
fi