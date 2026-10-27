# Knowledge Work Plugins 插件市场安装指南

> 第三方部署指南 · 非 Knowledge Work Plugins 官方仓库。官方项目：[anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace)为准。

[![⚡ 插件市场安装](https://img.shields.io/badge/%E2%9A%A1_%E6%8F%92%E4%BB%B6%E5%B8%82%E5%9C%BA%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#插件市场安装推荐用百度搭子)

## 插件市场安装（推荐：用百度搭子）

> [!TIP]
> 不想自己拼提示词，让百度搭子把整套岗位技能包装进 Claude，开会、写 SQL、审合同直接调用。

⚠️ 插件依赖 Claude Code 或 Cowork 客户端运行，本身不含模型，需要你自己的 Claude 账号或 API 额度。仓库里同时有多个岗位包，按需安装即可，不用全装。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/knowledge-work-plugins-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子先装 Claude Code CLI，再把插件市场加进来并安装指定的岗位插件，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Knowledge Work Plugins 是什么？

Knowledge Work Plugins 是开源的33.2k stars，Apache-2.0，Anthropic 开源的岗位技能插件合集，覆盖销售、数据、法务、财务等场景（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/anthropics/knowledge-work-plugins?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

Anthropic 维护的岗位技能插件市场：每个插件是一组 SKILL.md + 斜杠命令，把销售、数据、法务、财务、市场等岗位的固定流程封装成可直接调用的能力。

- 33.2k stars：2026-01 建仓，10 个月持续增长
- 按岗位拆分：销售、数据、法务、财务、市场各自独立
- 斜杠命令：/sales:call-prep、/data:write-query 直接调
- 技能自动触发：相关场景出现时自动加载
- 插件市场：一条命令加市场，再按名字装包
- Apache-2.0：可读可改可二次分发

（来源：[官方仓库](https://github.com/anthropics/knowledge-work-plugins)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 33.2k stars | Anthropic 亲自维护，更新稳定 |
| 按岗位划分 | 不用一次装全套，按需取用 |
| 斜杠命令 | 常见流程一键触发，少写提示词 |
| 技能自动触发 | 场景匹配时自动加载，不打断工作流 |
| Apache-2.0 | 可以读源码、改流程、内部复用 |

| 需要注意 | 说明 |
|---|---|
| 需要 Claude 客户端 | 没有 Claude Code / Cowork 用不了 |
| 依赖账号额度 | 插件不含模型，调用要花自己的额度 |
| 岗位包偏英文场景 | 中文业务流程需要自己调整 |
| 部分插件要额外授权 | 涉及外部系统时要单独配置 |
| 插件质量不均 | 不同岗位包的完成度不一样 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 快速部署（官方方式）

```bash
npm install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/knowledge-work-plugins
claude plugin install sales@knowledge-work-plugins
claude plugin list | grep -q knowledge-work-plugins && echo '插件已安装' || echo '未生效，先运行 claude --version 确认版本'
```

部署步骤来源：[https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace](https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace)

## 验证状态

| 场景 | 状态 |
|---|---|
| 仓库元数据已核对：33.2k stars、Apache-2.0、2026-01 建仓 | 已核对 2026-10-27 |
| README 确认安装命令为 plugin marketplace add + plugin install | 已核对 2026-10-27 |
| 未实测安装（本机未登录 Claude Code） | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

插件内部分能力会挂 MCP server；本仓库不注册 MCP，只负责安装与配置。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\knowledge-work-plugins-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

```text
/plugin                      # 查看已安装插件
/sales:call-prep             # 销售拜访准备
/data:write-query            # 写 SQL 查询
```

### 换一个岗位包

把 `sales` 换成市场里的其它名字即可：

```bash
claude plugin install data@knowledge-work-plugins
claude plugin install legal@knowledge-work-plugins
```

### 在 Cowork 里装

Cowork 客户端内置插件浏览入口，也可以直接从 [claude.com/plugins](https://claude.com/plugins/) 挑选后安装。

> ⚠️ 插件只是流程封装，输出质量取决于你的模型和输入材料，重要结论仍需人工复核。

## 常见坑

- `claude: command not found`：先 `npm install -g @anthropic-ai/claude-code`
- `/plugin` 不识别：Claude Code 版本太旧，先升级
- 装完没反应：插件按场景触发，不是常驻菜单
- 市场加不上：网络问题，重试 `plugin marketplace add`
- 命令不存在：确认插件名和岗位前缀，如 `/sales:`
- 不要一次装全部：插件越多上下文越挤

## 免责声明

本仓库为第三方指南，与 Knowledge Work Plugins 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
