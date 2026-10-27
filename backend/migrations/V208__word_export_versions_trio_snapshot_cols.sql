-- V208: 补齐 word_export_task_versions 的 trio snapshot 列（本仓库迁移缺口）
-- 背景：ORM（phase13_models.WordExportTaskVersion）定义了 snapshot_id / file_sha256，
--   但全仓 V*.sql 从未给本表建过这两列（V181 只建了 export_jobs_v2 / export_job_items_v2 的
--   snapshot_id；V205 的 varchar→uuid cast 因此在本表上失败）。V205 已在其余 3 表生效。
--   本迁移补建列（直接按 ORM 类型 uuid / varchar(64)，一步到位），并执行 V205 未竟的
--   trigger 孤立列清理；随后 V205 剩余语句可安全重放（快照类型已一致，ALTER 为无操作……
--   注意：本表列是新建的 uuid，不存在 varchar→uuid 转换需求）。
-- 幂等：全部 IF NOT EXISTS / DO $$ 判存。

ALTER TABLE word_export_task_versions
    ADD COLUMN IF NOT EXISTS snapshot_id UUID;

ALTER TABLE word_export_task_versions
    ADD COLUMN IF NOT EXISTS file_sha256 VARCHAR(64);

-- V205 遗留：删除孤立列 trigger（ORM 使用 trigger_source）
ALTER TABLE export_job_attempts
    DROP COLUMN IF EXISTS trigger;

-- （版本登记由 MigrationRunner 在应用成功后自动写入 schema_version，含 checksum，
--   禁止在迁移文件里手写 INSERT —— checksum 非空约束会失败。）
