"""一次性：修复 .env 尾部的 ENCRYPTION_KEY（上次写坏：乱码注释 + 全零 key）。用完即删。"""
import secrets
from pathlib import Path

p = Path("d:/java/GT_plan/.env")
text = p.read_text(encoding="utf-8", errors="replace")

idx = text.find("ENCRYPTION_KEY=")
if idx >= 0:
    text = text[:idx].rstrip() + "\n"

new_key = secrets.token_urlsafe(32)
text += (
    "# ----------------------------------------------------------\n"
    "# 敏感数据加密密钥（模型 API Key 等凭据的 Fernet 加密，任意随机串）\n"
    "# 生成方式: python -c \"import secrets; print(secrets.token_urlsafe(32))\"\n"
    "# 注意: 更换密钥后已保存的密文无法解密，需重新录入各模型 API Key\n"
    f"ENCRYPTION_KEY={new_key}\n"
)
p.write_text(text, encoding="utf-8")
print("new key written, length =", len(new_key), "unique chars =", len(set(new_key)))
