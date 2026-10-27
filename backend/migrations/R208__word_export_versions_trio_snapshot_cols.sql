-- R208: 回滚 V208
ALTER TABLE word_export_task_versions DROP COLUMN IF EXISTS snapshot_id;
ALTER TABLE word_export_task_versions DROP COLUMN IF EXISTS file_sha256;
