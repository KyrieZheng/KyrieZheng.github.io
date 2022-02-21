#!/bin/bash
# 运行cmcli
set -o errexit
set -o pipefail

hugo -D

echo "编译成功"