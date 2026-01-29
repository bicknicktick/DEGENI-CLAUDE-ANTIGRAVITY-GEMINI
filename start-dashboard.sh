#!/bin/bash
# Start DEGENI Dashboard with Live API

DEGENI_HOME="$HOME/DEGENI"

echo "Starting DEGENI Dashboard..."

# Start API server
pkill -f "degeni-api" 2>/dev/null
python3 "$DEGENI_HOME/bin/degeni-api" &
API_PID=$!
echo "API Server started (PID: $API_PID)"

# Start HTTP server for dashboard
pkill -f "python3 -m http.server 8080" 2>/dev/null
cd "$DEGENI_HOME/ui"
python3 -m http.server 8080 &
HTTP_PID=$!
echo "Dashboard server started (PID: $HTTP_PID)"

sleep 2
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  DEGENI Dashboard - LIVE                                      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "  Dashboard: http://localhost:8080/dashboard.html"
echo "  API:       http://localhost:8321"
echo ""
echo "  Press Ctrl+C to stop"
echo ""

wait
