---
name: shanghai-weather
description: Fetches and presents Shanghai weather data from the official Shanghai Meteorological Bureau (sh.cma.gov.cn). Use when user asks about Shanghai weather, current conditions, forecasts, temperature, air quality, or meteorological data for Shanghai. Triggers on: 天气, weather, 上海天气, temperature, forecast, AQI, 空气质量, 预警, warning, 台风, 雷达, 湿度, humidity, 紫外线, 穿衣, 指数, life index, 露点.
---

# Shanghai Weather Skill

Fetches real-time and forecast weather data for Shanghai from the official Shanghai Meteorological Bureau website.

## Data Sources

- **Primary**: http://sh.cma.gov.cn/sh/tqyb/ (Weather Report / 天气报告)
- **Backend API (smb.shweather.cn:5678)**: JSON endpoints for structured data
  - Hourly with humidity: `StationListAction/58367` (24h逐时，含湿度、露点、气压、降水)
  - 5-day forecast: `WeatherServiceFiveDay?stationid=58367`
  - Warnings: `GetAlertListByType?type=sh` (灾害天气预警)
  - AQI forecast: `GetTextinfoAQI` (空气质量预报，含首要污染物)
  - Radar images: `GetImgInfoList?type=多普勒雷达图&top=10` (多普勒雷达图URL列表)
  - Satellite images: `GetImgInfoList?type=卫星云图&top=10` (卫星云图URL列表)
  - Life index today: `ShzsybDay` (今天生活气象指数)
  - Life index tomorrow: `ShzsybMorrow` (明天生活气象指数)

## Instructions

### Step 1: Fetch Current Weather

Run the fetch script to get current weather data:
```bash
bash scripts/fetch_weather.sh current
```

**Expected output**: HTML page containing Shanghai current weather including:
- Temperature (temperature)
- Humidity (湿度)
- Wind direction and speed (风向、风力)
- Air quality index (AQI)
- Weather conditions (晴/阴/雨 etc.)
- Pressure and visibility data

**Alternative**: If the script fails, fetch directly:
```bash
curl -sk 'http://sh.cma.gov.cn/sh/tqyb/' \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'Referer: http://sh.cma.gov.cn/'
```

### Step 1.5: Fetch Humidity Data (Optional but Recommended)

For current humidity, use the backend API which provides 24-hour hourly data including humidity, dew point, pressure, and rainfall:

```bash
bash scripts/fetch_weather.sh hourly
```

**Response fields** (JSON):
- `humidity` - Relative humidity (%)
- `dewpoint` - Dew point (°C)
- `temperature` - Air temperature (°C)
- `airpress` - Air pressure (hPa)
- `windlevel` - Wind speed (m/s)
- `winddirection` - Wind direction (degrees)
- `rainhour` - Hourly rainfall (mm)
- `datatime_hour` - Hour (00-23)

**Alternative direct call**:
```bash
curl -sk 'http://smb.shweather.cn:5678/smb/Home/StationListAction/58367' \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Referer: http://sh.cma.gov.cn/'
```

### Step 2: Fetch Weather Warnings (Optional)

For active weather warnings (typhoons, heavy rain, strong wind, high temperature, etc.):

```bash
bash scripts/fetch_weather.sh warning
```

**Response fields**:
- `alertname` - Warning name (e.g. "暴雨", "台风", "大风")
- `alertlevel` - Warning level (蓝/黄/橙/红)
- `alertnames` - Short name for image asset
- `alertlevels` - Level abbreviation for image asset
- `info` - Additional info (warning ID, etc.)

**Expected outputs**:
- Warnings active: Returns array of warning objects
- No warnings: Returns `[]` (empty array) — page shows "当前暂无预警！"

**Alternative direct call**:
```bash
curl -sk 'http://smb.shweather.cn:5678/smb/Home/GetAlertListByType?type=sh' \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Referer: http://sh.cma.gov.cn/'
```

**Warning levels** (China standard):
- 🔵 蓝色 (Blue) - IV level
- 🟡 黄色 (Yellow) - III level
- 🟠 橙色 (Orange) - II level
- 🔴 红色 (Red) - I level (most severe)

### Step 3: Fetch AQI Forecast (Optional)

For air quality forecast with primary pollutant:

```bash
bash scripts/fetch_weather.sh aqi
```

**Response fields**:
- `publishtimes` - Publish timestamp
- `time` - Time period (e.g. "30日下午（12时—20时）")
- `aqi` - AQI quality level (优/良/轻度污染 etc.)
- `quality` - AQI range (e.g. "40-60")
- `first` - Primary pollutant (e.g. "O₃-8H", "-" for none)

**Alternative direct call**:
```bash
curl -sk 'http://smb.shweather.cn:5678/smb/Home/GetTextinfoAQI' \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Referer: http://sh.cma.gov.cn/'
```

### Step 3.5: Fetch Radar / Satellite Images (Optional)

For weather visualization images:

```bash
# Doppler radar
bash scripts/fetch_weather.sh radar

# Satellite cloud imagery
bash scripts/fetch_weather.sh satellite
```

**Response fields**:
- `infopath` - Relative image path (prepend `http://smb.soweather.com:5678/`)
- `backupfilename` - Full image URL
- `datatime` - Image timestamp
- `infotype` - Image type

**Image URL pattern**: `http://smb.soweather.com:5678/BackFile/Img/{year}/{month}/{day}/{filename}.png`

### Step 3.75: Fetch Life Weather Index (Optional)

For daily life suitability indices (clothing, UV, exercise, car wash, etc.):

```bash
bash scripts/fetch_weather.sh life-index
```

Returns two JSON arrays: today (`ShzsybDay`) and tomorrow (`ShzsybMorrow`).

**Response fields**:
- `guidepointname` - Index name (e.g. "紫外线", "穿衣指数", "运动指数")
- `guidepointlevel` - Level (e.g. "2级")
- `leveltips` - Level description (e.g. "弱", "一般")
- `guidepointdescription` - Detailed description
- `guidepointtips` - Practical advice

**Common index types**:
- 日照指数 (Sunshine index)
- 体感指数 (Perceived temperature index)
- 紫外线 (UV index)
- 穿衣指数 (Clothing index)
- 运动指数 (Exercise index)
- 洗车指数 (Car wash index)
- 感冒指数 (Cold/flu index)

### Step 4: Fetch 5-Day Forecast (Optional)

For 5-day forecast with weather, temperature, and rainfall probability:

```bash
bash scripts/fetch_weather.sh forecast
```

**Response fields**:
- `weather` - Daytime weather condition
- `weathernight` - Nighttime weather condition
- `mintemp` - Minimum temperature (°C)
- `maxtemp` - Maximum temperature (°C)
- `wind` - Wind direction
- `windspeed` - Wind speed level
- `waterprobability` - Precipitation probability (%)
- `week` - Day of week
- `foretime` - Forecast date

### Step 5: Extract and Present Weather Data

After fetching the HTML, extract key data points:

1. **Current Temperature**: Look for temperature values (通常在页面显眼位置)
2. **Weather Condition**: Look for weather description (晴、多云、阴、小雨等)
3. **Humidity**: Use the hourly endpoint (Step 1.5) for accurate humidity data
4. **Wind**: Look for 风向 and 风力
5. **Air Quality**: Look for AQI index and quality level

Format the response as:
```
上海当前天气
温度: XX°C
天气状况: ...
湿度: XX%
风向: ...
风力: ...
空气质量(AQI): XX (等级)
```

### Step 6: Provide Context and Advice

Based on the conditions:
- Suggest clothing appropriate for the temperature
- Note any weather advisories (高温、暴雨、大风等)
- Mention air quality considerations if AQI is high

## Troubleshooting

### Connection Issues
If sh.cma.gov.cn is unreachable:
1. Check network connectivity
2. Try alternative: http://sh.weather.com.cn/
3. Inform user and suggest checking again later

### Data Not Found
If expected data is missing from the response:
1. The website structure may have changed
2. Try refreshing the fetch
3. Report available data fields to the user

### Script Not Executable
If the script fails to run:
1. Ensure bash is available
2. Verify the script file exists in scripts/
3. Run with explicit bash path: `/bin/bash scripts/fetch_weather.sh current`
4. Full script usage: `bash scripts/fetch_weather.sh [current|airquality|lifestyle|hourly|forecast|warning|aqi|radar|satellite|life-index]`

## Examples

Example 1: Current weather request
User: "What is the weather in Shanghai?"
Actions:
1. Run `bash scripts/fetch_weather.sh current`
2. Parse HTML for temperature, humidity, wind, AQI
3. Present formatted weather report

Result:
```
上海当前天气
温度: 25°C
天气状况: 多云
湿度: 65%
风向: 东南风
风力: 3-4级
空气质量(AQI): 45 (优)
建议: 天气舒适，适合外出活动。
```

Example 2: Detailed forecast
User: "Help me plan my day in Shanghai"
Actions:
1. Fetch weather page
2. Extract all available data points
3. Provide contextual advice for the day

Result: Comprehensive weather summary with recommendations.

## Quality Notes
- Take time to parse the HTML carefully
- If data is ambiguous, present what was found and note uncertainties
- Do not fabricate weather data - only present what was successfully fetched
