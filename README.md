# Bash-CTF-OneLiners

works both with zhrc and bshrc.

```shell
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
```




```shell
BOLD="\e[1m"
RESET="\e[0m"
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
MAGENTA="\e[95m"
CYAN="\e[96m"
WHITE="\e[97m"
GRAY="\e[90m"

last=""
find . -maxdepth 2 2>/dev/null | sort | while read -r item; do
    dir=$(dirname "$item")
    if [ "$dir" != "$last" ]; then
        echo -e "\n${BLUE}${BOLD}╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "${BLUE}${BOLD}║ $dir ${RESET}"
        echo -e "${BLUE}${BOLD}╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝${RESET}"
        last="$dir"
    fi
    name=$(basename "$item")
    [ "$name" = "." ] && continue
    
    # Check permissions and build description
    perms=""
    desc=""
    [ -r "$item" ] && perms="${perms}${GREEN}${BOLD}R${RESET}" || perms="${perms}${RED}${BOLD}-${RESET}"
    [ -w "$item" ] && perms="${perms}${YELLOW}${BOLD}W${RESET}" || perms="${perms}${RED}${BOLD}-${RESET}"
    [ -x "$item" ] && perms="${perms}${CYAN}${BOLD}X${RESET}" || perms="${perms}${RED}${BOLD}-${RESET}"
    
    # Build description string - only show permissions you actually have (simple approach)
    desc=""
    sep=""
    
    if [ -r "$item" ]; then
        desc="${desc}${sep}${GREEN}${BOLD}readable${RESET}"
        sep="${WHITE}${BOLD}/${RESET}"
    fi
    
    if [ -w "$item" ]; then
        desc="${desc}${sep}${YELLOW}${BOLD}writable${RESET}"
        sep="${WHITE}${BOLD}/${RESET}"
    fi
    
    if [ -x "$item" ]; then
        desc="${desc}${sep}${CYAN}${BOLD}executable${RESET}"
        sep="${WHITE}${BOLD}/${RESET}"
    fi
    
    if [ -z "$desc" ]; then
        desc="${RED}${BOLD}no access${RESET}"
    fi
    
    # Get owner info
    owner=$(stat -c "%U" "$item" 2>/dev/null || echo "unknown")
    
    # File type and size
    if [ -d "$item" ]; then
        echo -e "${MAGENTA}${BOLD}📁 ${WHITE}${BOLD}${name}/${RESET} ${GRAY}[${RESET}${perms}${GRAY}]${RESET} ${GRAY}(${RESET}${desc}${GRAY})${RESET} ${GRAY}→${RESET} ${CYAN}${BOLD}${owner}${RESET}"
    else
        size=$(du -h "$item" 2>/dev/null | cut -f1)
        if [ -w "$item" ]; then
            echo -e "${RED}${BOLD}🔥 ${WHITE}${BOLD}${name}${RESET} ${GRAY}[${RESET}${perms}${GRAY}]${RESET} ${GRAY}(${RESET}${desc}${GRAY})${RESET} ${YELLOW}${BOLD}${size}${RESET} ${GRAY}→${RESET} ${CYAN}${BOLD}${owner}${RESET}"
        elif [ -x "$item" ]; then
            echo -e "${CYAN}${BOLD}➤ ${WHITE}${BOLD}${name}${RESET} ${GRAY}[${RESET}${perms}${GRAY}]${RESET} ${GRAY}(${RESET}${desc}${GRAY})${RESET} ${YELLOW}${BOLD}${size}${RESET} ${GRAY}→${RESET} ${CYAN}${BOLD}${owner}${RESET}"
        else
            echo -e "${GRAY}❌ ${WHITE}${name}${RESET} ${GRAY}[${RESET}${perms}${GRAY}]${RESET} ${GRAY}(${RESET}${desc}${GRAY})${RESET} ${YELLOW}${size}${RESET} ${GRAY}→${RESET} ${CYAN}${owner}${RESET}"
        fi
    fi
done
```

