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

## 快速安装

```bash
git clone https://github.com/Lucasyao1985/shanghai-weather.git
```

将文件夹放入 Claude Code skills 目录：
- **Windows:** `C:\Users\<你的用户名>\.claude\skills\`
- **macOS/Linux:** `~/.claude/skills/`

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