#!/bin/bash

# /bin/generate_org_accountIds_assume.sh
export AWS_PAGER=""
export AWS_DEFAULT_OUTPUT=json

OUTPUT_FILE="/bin/accounts.json"

# AWS Organizations에서 계정 목록 가져오기
aws organizations list-accounts \
  --region us-east-1 --query \
  'Accounts[?Status==`ACTIVE`].[Name,Id]' \
  --output json |
  jq -r 'map({(.[0]): .[1]}) | add' | sudo tee "$OUTPUT_FILE"

echo "계정 목록이 ${OUTPUT_FILE}에 저장되었습니다."
