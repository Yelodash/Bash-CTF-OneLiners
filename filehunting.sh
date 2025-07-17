# Color definitions
BOLD="\e[1m"
RESET="\e[0m"
RED="\e[1;31m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
GRAY="\e[0;37m"

last=""
find . -type f \
  ! -regex ".*\/\(examples\|vendor\|bin\|src\|node_modules\|test\|tests\|docs\|documentation\|tmp\|temp\|log\|logs\|libraries\|console-setup\|themes\|properties\|plugins\|classes\|ufw\|php\|pear\|web-inf\|host-manager\|doc\|language\|components\|dpkg\|cloud\|modules\|layouts\|manifest\|manifests\|images\|media\|sampledata\|templates\|lib\|proc\|mime\|snap\|run\|usr\|share\|sys\|boot\|cache\|installation\|system\|systemd\\.svn\|\.hg\)\/.*" \
  ! -regex ".*\.\(log\|tmp\|bak\|dll\|pm\|pod\|twig\|java\|class\|properties\|html\|jsp\|gif\|png\|svg\|status\|woff\|profile\|send\|load\|cfg\|jar\|xsd\|mo\|js\|xsl\|css\|packlist\|pl\|ico\|scss\|h\)" \
  ! -regex ".*/\(Thumbs\.db\|desktop\.ini\|\.DS_Store\)$" \
  2>/dev/null | sort | while read -r file; do
    dir=$(dirname "$file")
    if [ "$dir" != "$last" ]; then
      echo -e "\n${BLUE}${BOLD}===================== [ $dir ] =====================${RESET}"
      last="$dir"
    fi
    size=$(du -k "$file" | cut -f1)
    name=$(basename "$file")
    if [[ "$name" =~ pass|cred|key|secret|config|sql|backup|bak|ini|xml|json|env ]]; then
      echo -e "${RED}${BOLD}** HIGH VALUE **${RESET} -> $file [${YELLOW}${size} KB${RESET}]"
    else
      echo -e "${GRAY} - $name [${YELLOW}${size} KB${GRAY}]${RESET}"
    fi
  done
