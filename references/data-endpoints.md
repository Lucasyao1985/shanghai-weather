# Shanghai Weather Data Endpoints

Documentation for weather data available on sh.cma.gov.cn (上海市气象局).

## Primary Pages

### Weather Report (天气报告)
- **URL**: http://sh.cma.gov.cn/sh/tqyb/
- **Description**: Main weather conditions page for Shanghai center
- **Contains**: Current temperature, humidity, wind, AQI, weather description
- **Access method**: Direct GET with proper User-Agent and Referer headers

### Air Quality Forecast (空气质量预报)
- **URL**: http://sh.cma.gov.cn/sh/tqyb/#AQI (same page, hash section)
- **Description**: AQI index and air quality levels for Shanghai districts
- **Access method**: Same as weather report page

### Life Weather Index (生活气象指数)
- **URL**: http://sh.cma.gov.cn/sh/tqyb/#shzsyb (same page, hash section)
- **Description**: Weather suitability for daily activities (clothing, exercise, etc.)
- **Access method**: Same as weather report page

## Data Format

The site uses traditional ASP.NET layout with data loaded via:
- Initial server-rendered HTML
- jQuery AJAX calls to JSON endpoints (e.g., `ldjson()`, `wxjson()`)
- Highcharts.js for data visualization (hourly charts)

### Key JavaScript Files
- `material/Static/js/HighcharsHour.js` - Renders hourly temperature and rainfall
- `material/Static/js/Top.js` - Manages page layout and responsive behavior
- `material/Resources/JsLib/Highcharts/` - Charting library

### Known Data Patterns
From `HighcharsHour.js`, the site passes arrays for:
- `array` - Time categories (hourly)
- `arraytemp` - Temperature values by hour
- `arrayrain` - Precipitation values by hour

## District Coverage

The site has subdirectories for Shanghai districts:
- `../../pd/` - Pudong
- `../../bs/` - Baoshan
- `../../mh/` - Minhang
- `../../jd/` - Jiading
- `../../js/` - Jinshan
- `../../sj/` - Songjiang
- `../../qp/` - Qingpu
- `../../fx/` - Fengxian
- `../../cm/` - Chongming

## External Resources

- Shanghai Weather Network: http://sh.weather.com.cn/
- China Meteorological Data: http://data.cma.cn/
- National Meteorological Center: http://www.cma.gov.cn/

## JSON API Endpoints (Backend: smb.shweather.cn:5678)

The actual weather data is served by a backend API at `smb.shweather.cn:5678/smb/Home/`.

### Hourly Weather with Humidity
- **URL**: `http://smb.shweather.cn:5678/smb/Home/StationListAction/58367`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: Array of 24 hourly records
- **Fields**: `temperature`, `humidity`, `dewpoint`, `airpress`, `windlevel`, `winddirection`, `rainhour`, `datatime_hour`
- **stationid**: 58367 (Shanghai center station)

### 5-Day Forecast
- **URL**: `http://smb.shweather.cn:5678/smb/Home/WeatherServiceFiveDay?stationid=58367`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: Array of 5 forecast records
- **Fields**: `weather`, `weathernight`, `mintemp`, `maxtemp`, `wind`, `windspeed`, `waterprobability`, `week`, `foretime`

### Weather Warnings (灾害天气预警)
- **URL**: `http://smb.shweather.cn:5678/smb/Home/GetAlertListByType?type=sh`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: Array of warning objects, or `[]` when no active warnings
- **Fields**: `alertname`, `alertlevel` (蓝/黄/橙/红), `alertnames`, `alertlevels`, `info`

### AQI Forecast
- **URL**: `http://smb.shweather.cn:5678/smb/Home/GetTextinfoAQI`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: JSON with `publishtimes` and `data` array
- **Fields**: `time` (period), `aqi` (quality level), `quality` (range), `first` (primary pollutant)

### Radar Images
- **URL**: `http://smb.shweather.cn:5678/smb/Home/GetImgInfoList?type=多普勒雷达图&top=10`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: Array of image metadata objects
- **Fields**: `infopath` (relative), `backupfilename` (full URL), `datatime`, `infotype`

### Satellite Images
- **URL**: `http://smb.shweather.cn:5678/smb/Home/GetImgInfoList?type=卫星云图&top=10`
- **Method**: Same as radar
- **Returns**: Array of image metadata objects

### Life Weather Index (today)
- **URL**: `http://smb.shweather.cn:5678/smb/Home/ShzsybDay`
- **Method**: GET with `X-Requested-With: XMLHttpRequest` header
- **Returns**: Array of index objects
- **Fields**: `guidepointname`, `guidepointlevel`, `leveltips`, `guidepointdescription`, `guidepointtips`

### Life Weather Index (tomorrow)
- **URL**: `http://smb.shweather.cn:5678/smb/Home/ShzsybMorrow`
- **Method**: Same as today
- **Returns**: Array of index objects

## Known Issues

- SSL certificate may be self-signed in some environments (use `--insecure` or `curl -k`)
- Requires Baidu analytics cookies (`HMACCOUNT`, `BAIDUID_BFESS`) for full functionality
- Site uses IE-compatible code with extensive CSS hacks
- Some data loads via cross-domain requests (`.xdomainrequest.min.js`)
