#!/bin/bash
# 运行cmcli
set -o errexit
set -o pipefail

name=${1:-""}
if ! [ $name ]; then
    echo "请输入要创建的markdowm-name：👇"
    read -r name
fi

if ! [ $name ]; then
    echo "创建失败"
    exit
fi

hugo new posts/${name}.md

echo "创建成功"