-- V209: 补齐最后一处 orm_extra（本仓库迁移缺口收尾）
-- export_jobs_v2.readiness：ORM（phase13_models.ExportJobV2，V181 phase4 trio 注释段）定义了
-- JSONB readiness，但 V181 的 ALTER 清单漏了这一列（snapshot_id/kind/year/trio_* 都有，
-- 唯独 readiness 没建）。JSONB 可空、无默认，additive 补齐零风险。

ALTER TABLE export_jobs_v2
    ADD COLUMN IF NOT EXISTS readiness JSONB;

COMMENT ON COLUMN export_jobs_v2.readiness IS 'phase4 trio 导出就绪检查结果；NULL=未检查';
