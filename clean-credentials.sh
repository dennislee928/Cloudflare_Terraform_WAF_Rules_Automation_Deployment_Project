#!/bin/bash

echo "開始清理專案..."

# 清理 js-scripts 目錄
echo "清理 js-scripts 目錄..."
js_files=(
    "js-scripts/set_waf_rules.js"
    "js-scripts/user-agent.js"
    "js-scripts/place_autorenew_certificates.js"
)

for file in "${js_files[@]}"; do
    if [ -f "$file" ]; then
        echo "處理檔案: $file"
        sed -i.bak 's/"X-Auth-Email": ".*"/"X-Auth-Email": "your-email@example.com"/g' "$file"
        sed -i.bak 's/"X-Auth-Key": ".*"/"X-Auth-Key": "your-api-key"/g' "$file"
        sed -i.bak 's/cloudflare.admin@.*"/your-email@example.com"/g' "$file"
        sed -i.bak 's/daf08ebac1a4805ecb820fa699ca0d8b.*/your-api-key"/g' "$file"
        rm -f "$file.bak"
    fi
done

# 創建 js-scripts/.gitignore
echo "創建 js-scripts/.gitignore..."
cat > js-scripts/.gitignore << EOF
.env
*.log
node_modules/
.DS_Store
EOF

# 創建 js-scripts/.env.example
echo "創建 js-scripts/.env.example..."
cat > js-scripts/.env.example << EOF
CLOUDFLARE_API_TOKEN=your_api_token_here
CLOUDFLARE_ACCOUNT_ID=your_account_id_here
DOMAIN_NAME=your_domain_here
EOF

# 清理 cloudflare-terraform 目錄
echo "清理 cloudflare-terraform 目錄..."
if [ -f "cloudflare-terraform/terraform.tfvars" ]; then
    rm cloudflare-terraform/terraform.tfvars
fi

# 創建 cloudflare-terraform/terraform.tfvars.example
cat > cloudflare-terraform/terraform.tfvars.example << EOF
cloudflare_api_token = "your_api_token_here"
account_id = "your_account_id_here"
zone_names = ["example.com"]
plan = "free"
dns_records = {
  "example.com" = [
    {
      type  = "A"
      name  = "@"
      value = "1.2.3.4"
      ttl   = 1
    }
  ]
}
EOF

# 更新根目錄的 .gitignore
echo "更新根目錄 .gitignore..."
cat > .gitignore << EOF
# General
.DS_Store
*.log
.env
.env.*
!.env.example

# JavaScript
node_modules/
coverage/
*.log

# Terraform
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
.terraformrc
terraform.rc
EOF

# 移除任何可能存在的敏感檔案
echo "移除敏感檔案..."
find . -name ".env" -type f -delete
find . -name "terraform.tfvars" -type f -delete
find . -name ".terraform" -type d -exec rm -rf {} +
find . -name "*.tfstate*" -type f -delete

echo "清理完成！"
