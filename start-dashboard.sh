#!/bin/bash
# Start DEGENI Dashboard with Live API
# by BITZY.ID

DEGENI_HOME="$HOME/DEGENI"

C='\033[0;36m'
G='\033[0;32m'
Y='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${C}Starting DEGENI Dashboard...${NC}"
echo ""

# Kill existing processes
pkill -f "degeni-api" 2>/dev/null
pkill -f "python3 -m http.server 8080" 2>/dev/null
sleep 1

# Start API server
echo -e " ${Y}[1/2]${NC} Starting API server..."
nohup python3 "$DEGENI_HOME/bin/degeni-api" > "$DEGENI_HOME/logs/api.log" 2>&1 &
API_PID=$!
sleep 2

# Verify API is running
if curl -s http://localhost:8321/api/status > /dev/null 2>&1; then
    echo -e "       ${G}✓${NC} API running on port 8321"
else
    echo -e "       ${Y}!${NC} API may not be responding"
fi

# Start HTTP server for dashboard
echo -e " ${Y}[2/2]${NC} Starting dashboard server..."
cd "$DEGENI_HOME/ui"
nohup python3 -m http.server 8080 > "$DEGENI_HOME/logs/dashboard.log" 2>&1 &
HTTP_PID=$!
sleep 1
echo -e "       ${G}✓${NC} Dashboard running on port 8080"

echo ""
echo -e "${C}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${NC}  ${G}DEGENI Dashboard - LIVE${NC}                                      ${C}║${NC}"
echo -e "${C}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Dashboard: ${G}http://localhost:8080/dashboard.html${NC}"
echo -e "  API:       ${G}http://localhost:8321${NC}"
echo ""
echo -e "  ${Y}Open the dashboard URL in your browser!${NC}"
echo ""
echo -e "  To stop: ${C}pkill -f degeni-api; pkill -f 'http.server 8080'${NC}"
echo ""

# Try to open browser (optional)
if command -v xdg-open &> /dev/null; then
    xdg-open "http://localhost:8080/dashboard.html" 2>/dev/null &
elif command -v open &> /dev/null; then
    open "http://localhost:8080/dashboard.html" 2>/dev/null &
fi
