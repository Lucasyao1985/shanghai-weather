<div align="center">

[![Release version](https://img.shields.io/github/v/release/Lucasyao1985/shanghai-weather?color=brightgreen&label=Latest&style=for-the-badge)](https://github.com/Lucasyao1985/shanghai-weather/releases "Latest Release")
[![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?&logo=discord&logoColor=white&style=for-the-badge)](https://discord.gg/H5MNcFW63r "Discord")
[![License: Unlicense](https://img.shields.io/badge/-Unlicense-red.svg?style=for-the-badge)](LICENSE "License")
[![Commits](https://img.shields.io/github/commit-activity/m/Lucasyao1985/shanghai-weather?label=commits&style=for-the-badge)](https://github.com/Lucasyao1985/shanghai-weather/commits "Commit History")

</div>

# 上海天气 Skill for Claude Code

从 [上海市气象局](http://sh.cma.gov.cn/) 获取上海实时天气、湿度、预报、AQI、灾害预警、雷达图、卫星云图和生活气象指数。

## 功能特性

| 功能 | 数据来源 | 说明 |
|------|----------|------|
| 实时天气 | 逐时 JSON API | 温度、湿度、露点、气压、风速、风向、降水 |
| 5天预报 |weatherServiceFiveDay API | 晴/阴/雨、高低温、风向风速、降水概率 |
| 生活气象指数 | ShzsybDay / ShzsybMorrow | 日照、体感、紫外线、穿衣、运动等 8+ 指数 |
| AQI 预报 | GetTextinfoAQI | 空气质量等级、数值范围、首要污染物 |
| 灾害预警 | GetAlertListByType | 暴雨/台风/大风等预警（蓝/黄/橙/红） |
| 雷达图 | GetImgInfoList | 10 张最新多普勒雷达图 PNG |
| 卫星云图 | GetImgInfoList | 卫星云图 URL 列表 |

## 安装

### 方式一：Git Clone

```bash
git clone https://github.com/Lucasyao1985/shanghai-weather.git
```

### 方式二：直接下载

从 [Releases](../../releases) 下载 ZIP 解压到 Claude Code skills 目录。

## 在 Claude Code 中启用

1. 确保 skill 文件夹位于 Claude Code 的 skills 目录：
   - Windows: `C:\Users\<用户名>\.claude\skills\shanghai-weather\`
   - macOS/Linux: `~/.claude/skills/shanghai-weather/`

2. 重启 Claude Code 或在对话中使用 skill，Claude 会按 frontmatter 中的描述自动匹配。

## 使用示例

直接问 Claude 关于上海天气的问题：

```
上海现在天气怎么样？湿度多少？

上海未来5天天气

上海今天的生活气象指数

上海有灾害预警吗？

上海的AQI预报怎么样？

上海最新雷达图
```

Skill 会根据你的问题自动调用对应的数据端点，无需手动选择。

## 数据来源

- **主站**: [http://sh.cma.gov.cn/](http://sh.cma.gov.cn/) — 上海市气象局
- **后端 API**: `http://smb.shweather.cn:5678/smb/Home/`
- **站号**: 58367（上海市中心气象站）

## Skill 模式速查

```bash
bash scripts/fetch_weather.sh [模式]

current      - 天气报告页 HTML（原始数据）
hourly       - 24小时逐时 JSON（含湿度、露点、气压、降水）
forecast     - 5天预报 JSON（天气、温度、降水概率）
aqi          - AQI 预报 JSON（等级、范围、首要污染物）
warning      - 灾害预警 JSON（预警名称、级别）
radar        - 雷达图 URL 列表 JSON
satellite    - 卫星云图 URL 列表 JSON
life-index   - 今天+明天生活指数 JSON
```

## License

Unlicense
