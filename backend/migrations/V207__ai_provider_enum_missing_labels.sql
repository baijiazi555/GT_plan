-- V207: ai_provider_enum 补齐 ORM (AIProvider) 已定义、DB 枚举缺失的 5 个标签
-- 背景：/api/projects 500 复盘（2026-10-27）发现两份代码副本共用一库导致枚举漂移：
--   读方向漂移已修 ORM（ProjectType/UserRole/AdjustmentType/OutboxStatus/ReportType）；
--   本文件修写方向：ORM 写入这 5 个 provider 值会被 PG 拒绝（invalid input value）。
-- 幂等：IF NOT EXISTS，可重复执行（V109 同款写法）。

ALTER TYPE ai_provider_enum ADD VALUE IF NOT EXISTS 'deepseek';
ALTER TYPE ai_provider_enum ADD VALUE IF NOT EXISTS 'zhipu';
ALTER TYPE ai_provider_enum ADD VALUE IF NOT EXISTS 'qwen';
ALTER TYPE ai_provider_enum ADD VALUE IF NOT EXISTS 'azure_openai';
ALTER TYPE ai_provider_enum ADD VALUE IF NOT EXISTS 'custom';
