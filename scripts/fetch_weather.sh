#!/bin/bash
# fetch_weather.sh
# Fetches Shanghai weather data from sh.cma.gov.cn
#
# Usage: bash fetch_weather.sh [current|airquality|lifestyle|hourly|forecast|warning|aqi|radar|satellite|life-index]

set -euo pipefail

MODE="${1:-current}"
BASE_URL="http://sh.cma.gov.cn"
UA="Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36"

fetch_page() {
  local url="$1"
  curl -sk "$url" \
    -H "User-Agent: $UA" \
    -H "Referer: $BASE_URL/" \
    -H "Accept: application/json, text/javascript, */*; q=0.01" \
    --max-time 30
}

fetch_json() {
  local url="$1"
  curl -sk "$url" \
    -H "User-Agent: $UA" \
    -H "Referer: $BASE_URL/" \
    -H "Accept: application/json, text/javascript, */*; q=0.01" \
    -H "X-Requested-With: XMLHttpRequest" \
    --max-time 30
}

case "$MODE" in
  "current")
    echo "=== Fetching current weather from $BASE_URL/sh/tqyb/ ==="
    fetch_page "$BASE_URL/sh/tqyb/"
    ;;
  "home")
    echo "=== Fetching homepage $BASE_URL ==="
    fetch_page "$BASE_URL"
    ;;
  "airquality")
    echo "=== Fetching air quality from $BASE_URL/sh/tqyb/#AQI ==="
    fetch_page "$BASE_URL/sh/tqyb/"
    ;;
  "lifestyle")
    echo "=== Fetching lifestyle index from $BASE_URL/sh/tqyb/#shzsyb ==="
    fetch_page "$BASE_URL/sh/tqyb/"
    ;;
  "hourly")
    echo "=== Fetching 24h hourly data with humidity from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/StationListAction/58367"
    ;;
  "forecast")
    echo "=== Fetching 5-day forecast from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/WeatherServiceFiveDay?stationid=58367"
    ;;
  "warning")
    echo "=== Fetching disaster weather warnings from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/GetAlertListByType?type=sh"
    ;;
  "aqi")
    echo "=== Fetching AQI forecast from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/GetTextinfoAQI"
    ;;
  "radar")
    echo "=== Fetching Doppler radar image list from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/GetImgInfoList?type=多普勒雷达图&top=10"
    ;;
  "satellite")
    echo "=== Fetching satellite cloud image list from smb.shweather.cn ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/GetImgInfoList?type=卫星云图&top=10"
    ;;
  "life-index")
    echo "=== Fetching daily life weather index from smb.shweather.cn ==="
    echo "=== Today ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/ShzsybDay"
    echo "=== Tomorrow ==="
    fetch_json "http://smb.shweather.cn:5678/smb/Home/ShzsybMorrow"
    ;;
  *)
    echo "Usage: bash fetch_weather.sh [current|airquality|lifestyle|hourly|forecast|warning|aqi|radar|satellite|life-index]"
    exit 1
    ;;
esac
