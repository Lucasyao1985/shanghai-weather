# Shanghai Weather
<p align="center">
  <a href="https://github.com/Lucasyao1985/shanghai-weather">GitHub</a> | <a href="SKILL.md">SKILL.md</a>
</p>
<p align="center">
  <a href="https://github.com/Lucasyao1985/shanghai-weather"><img alt="Release version" src="https://img.shields.io/github/v/release/Lucasyao1985/shanghai-weather?color=2da44e&label=Latest&style=for-the-badge" /></a>
  <a href="https://github.com/Lucasyao1985/shanghai-weather/commits"><img alt="Last commit" src="https://img.shields.io/github/last-commit/Lucasyao1985/shanghai-weather?color=0969da&label=Last%20commit&style=for-the-badge" /></a>
  <a href="README.zh-CN.md"><img alt="中文" src="https://img.shields.io/badge/中文-da3633?style=for-the-badge" /></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-2da44e?style=for-the-badge" /></a>
</p>

---

**Shanghai Weather is a [Claude Code](https://claude.ai) skill that fetches real-time and forecast weather data for Shanghai from the official [Shanghai Meteorological Bureau](http://sh.cma.gov.cn/).** One query, instant results.

<table>
<tr><td><b>Real-time conditions</b></td><td>Temperature, humidity, dew point, pressure, wind speed, precipitation.</td></tr>
<tr><td><b>5-day forecast</b></td><td>High/low temps, wind, rain probability for the coming days.</td></tr>
<tr><td><b>Air quality (AQI)</b></td><td>Current AQI level, range, and primary pollutant.</td></tr>
<tr><td><b>Severe weather alerts</b></td><td>Live warnings for typhoon, rainstorm, gale, and more.</td></tr>
<tr><td><b>Weather radar</b></td><td>10-minute interval doppler radar images.</td></tr>
</table>

---

## Quick Install

```bash
git clone https://github.com/Lucasyao1985/shanghai-weather.git
```

Place the folder in your Claude Code skills directory:
- **Windows:** `C:\Users\<you>\.claude\skills\`
- **macOS/Linux:** `~/.claude/skills/`

## Usage

Ask Claude about Shanghai weather naturally:

```
What's the weather in Shanghai?
What's the humidity in Shanghai?
Shanghai 5-day forecast?
Shanghai air quality?
Any weather warnings?
Show me the Shanghai weather radar
```

The skill auto-triggers on Shanghai weather queries and returns structured data.

## How It Works

```
Query → [fetch_weather.sh] → [Shanghai Met Bureau API] → Structured response
```

The skill directly queries the official Shanghai Meteorological Bureau endpoints (sh.cma.gov.cn) for real-time data, forecasts, AQI, and alerts.

## Project Structure

```
shanghai-weather/
├── SKILL.md                 # Skill definition
├── README.md                # This file (English)
├── README.zh-CN.md          # Chinese documentation
├── scripts/
│   └── fetch_weather.sh     # Core data fetching script
└── references/
```

## License

MIT — see [LICENSE](LICENSE).

Built with [opencode](https://github.com/anomalyco/opencode).