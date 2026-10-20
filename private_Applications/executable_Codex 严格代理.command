#!/bin/bash
echo "此旧入口现使用显式代理启动；已移除导致应用无法启动的额外沙箱，不保证全进程禁止直连。"
exec "$HOME/bin/codex-proxy"
