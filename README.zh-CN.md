# 上海天气 Skill
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

**上海天气是一个 [Claude Code](https://claude.ai) 技能，从 [上海市气象局](http://sh.cma.gov.cn/) 获取上海实时和预报天气数据。** 一问即答。

<table>
<tr><td><b>实时天气</b></td><td>温度、湿度、露点、气压、风速、降水量。</td></tr>
<tr><td><b>5 天预报</b></td><td>最高/低温、风力、降雨概率。</td></tr>
<tr><td><b>空气质量 (AQI)</b></td><td>当前 AQI 等级、范围、首要污染物。</td></tr>
<tr><td><b>灾害预警</b></td><td>台风、暴雨、大风等实时预警信息。</td></tr>
<tr><td><b>气象雷达</b></td><td>10 分钟间隔的多普勒雷达图像。</td></tr>
</table>

---

## 快速安装

```bash
git clone https://github.com/Lucasyao1985/shanghai-weather.git
```

将文件夹放入 Claude Code skills 目录：
- **Windows:** `C:\Users\<你的用户名>\.claude\skills\`
- **macOS/Linux:** `~/.claude/skills/`

## 使用方法

直接向 Claude 提问上海天气相关的问题：

```
上海今天天气怎么样？
上海湿度多少？
上海未来 5 天天气预报？
上海空气质量如何？
上海有什么天气预警吗？
看看上海的气象雷达图
```

技能会自动识别上海天气相关问题并返回结构化数据。

## 工作原理

```
提问 → [fetch_weather.sh] → [上海市气象局 API] → 结构化天气数据
```

技能直接查询上海市气象局官方端点（sh.cma.gov.cn），获取实时数据、预报、AQI 和预警信息。

## 项目结构

```
shanghai-weather/
├── SKILL.md                 # 技能定义文件
├── README.md                # 英文文档
├── README.zh-CN.md          # 中文文档
├── scripts/
│   └── fetch_weather.sh     # 核心数据获取脚本
└── references/
```

## 许可证

MIT — 见 [LICENSE](LICENSE)。

由 [opencode](https://github.com/anomalyco/opencode) 构建。