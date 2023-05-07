# minutes_terraform

### 前提
- aws cli がインストールされていること
- .aws/credentials ファイルが、以下のように正しく記載されていること

```.aws/credentials
[minutes]
aws_access_key_id      = AWSアクセスキー
aws_secret_access_key  = AWSシークレットアクセスキー
```

### Tips
```
# フォーマット
$ terraform fmt --recursive

# 差分確認
$ cd environments/prod
$ terraform plan

# 適用
$ cd environments/prod
$ terraform apply
$ (yes と答える)
```
