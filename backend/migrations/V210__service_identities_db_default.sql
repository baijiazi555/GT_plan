-- V210: service_identities.id 补 DB 层 default
-- 背景：全新库初始化时基础表由 ORM create_all 建（id 只有 Python 端 default=uuid.uuid4，
--   DB 层无 default），而 V106 等迁移用裸 SQL INSERT 不带 id，依赖 DB default ⇒ NotNullViolation。
--   本迁移把 id 的 DB default 补齐（gen_random_uuid()），与迁移链假设对齐；
--   create_all 建的表与迁移建的表现在行为一致。

ALTER TABLE service_identities
    ALTER COLUMN id SET DEFAULT gen_random_uuid();
