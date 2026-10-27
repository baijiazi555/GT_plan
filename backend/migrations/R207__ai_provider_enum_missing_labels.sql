-- R207: V207 回滚脚本（ai_provider_enum 收缩在 PG 中不可逆，回滚为无操作占位）
-- PG 的 ALTER TYPE ... DROP VALUE 不存在；标签保留无害（无 ORM 引用的枚举标签不影响任何行为）。
SELECT 1;
