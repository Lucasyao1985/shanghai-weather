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

**上海天气是一个 [Claude Code](https://claude.ai) 技能，从 [上海市气象局](http://sh.cma.gov.cn/) 获取上海实时和预报天气数据。**

## 功能特点

| 功能 | 数据源 | 说明 |
|------|----------|------|
| 实时天气 | 实时 JSON API | 温度、湿度、露点、气压、风速、风向、降水量 |
| 5 天预报 | weatherServiceFiveDay API | 晴/阴/雨、高低温度、风力风向、降水概率 |
| 生活指数 | ShzsybDay / ShzsybMorrow | 晾晒、化妆、防晒、穿、舒适度、运动等 8+ 指数 |
| AQI 预报 | GetTextinfoAQI | 空气质量等级、数值范围、首要污染物 |
| 灾害预警 | GetAlertListByType | 暴雨/台风/大雾预警（蓝/黄/橙/红） |
| 雷达图 | GetImgInfoList | 10 分钟间隔多普勒雷达图 PNG |
| 卫星云图 | GetImgInfoList | 卫星云图 URL 列表 |

---

## 快速安装

```bash
git clone https://github.com/Lucasyao1985/shanghai-weather.git
```

将文件夹放入 Claude Code skills 目录：
- **Windows:** `C:\Users\<你的用户名>\.claude\skills\`
- **macOS/Linux:** `~/.claude/skills/`

## 使用示例

直接向 Claude 提问：

```
上海今天天气怎么样？湿度多少？
上海未来 5 天天气预报
上海空气质量如何？AQI 预报
上海有什么天气预警吗？
看看上海的气象雷达图
上海今天适合晾晒吗？
```

## 文件结构

```
shanghai-weather/
├── SKILL.md           # 技能定义文件
├── README.md          # 英文文档
├── README.zh-CN.md    # 中文文档
├── scripts/           # 执行脚本
│   └── fetch_weather.sh  # 核心数据获取脚本
└── references/        # 参考资料
```

## 许可证

MIT — 见 [LICENSE](LICENSE)。

由 [opencode](https://github.com/anomalyco/opencode) 构建。