# Changelog

## Unreleased

- 普通 `table` 默认采用首尾双横线并去除网格, 无需额外包装; 保留旧 `ruled-table`、表题、引用、合并单元格和重复表头.
- 更新示例和初始化模板, 增加 `just check-tables` 验证普通、旧包装及跨页表格.

## 2026-07-22 — v0.1.0

- 使用 `unofficial-pku-mpl` 作为 Universe 包名；远程仓库名为 `pkumpl-typst`.
- 修正 Universe 发布清单：保留模板缩略图路径，缩略图按 250 PPI 重新生成；模板初始化测试改用绝对包导入.
- 增加 `windows` 与 `notofandol` 字体预设，并使 `sans()`/`mono()` 跟随当前字体配置；在 README 中补充跨平台字体安装说明.
- 明确标注本项目参考并移植自 [`CastleStar14654/PKUMpLtX`](https://github.com/CastleStar14654/PKUMpLtX)，修正示例中的上游项目链接.
- 移除全局页顶浮动设置，避免初始化模板的首个图跑到标题区之前；致谢正文改为斜体.
- 对照 `PKUMpLtX` 的示例 PDF 打磨 Typst 版页面几何、正文 12pt、行距、标题间距与标题编号.
- 调整 macOS 正文与粗体字重，补齐二级/三级标题 2em 缩进，并按 LaTeX hyperref 默认值区分交叉引用、文献引用和 URL 的颜色.
- 修正灰色说明中的公式颜色，并补齐致谢示例中 `acknowledgments` 的斜体效果.
- 校准图表浮动位置、图题换行、表题位置、表格双横线、页码和附录编号.
- 补充表格脚注示例, 并更新 README 中的使用说明与已知差异.
- 完成 `PKUMpLtX` 示例模板的基础 Typst 移植.
- 加入 macOS、Noto 和 Fandol 字体配置, APS CSL 参考文献样式及示例素材.
- 将摘要行距校准到原始 `mpltx.cls` 的 11pt/13pt 与 `\\linespread{1.3}` 组合效果, 并同步更新初始化模板说明.
