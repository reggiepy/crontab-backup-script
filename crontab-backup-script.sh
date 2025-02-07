#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR=$(dirname "$0")

# 备份目录
BACKUP_DIR="$SCRIPT_DIR/crontab_backup"
# 当前日期
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
# 备份文件名
BACKUP_FILE="$BACKUP_DIR/crontab_backup_$DATE"

# 最大备份数量
MAX_BACKUPS=5

# 检查备份目录是否存在，不存在则创建
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# 检查备份目录中现有的文件数量
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | grep -c "crontab_backup_")

# 如果备份文件数量超过最大限制，则删除最旧的备份文件
if [ "$BACKUP_COUNT" -ge "$MAX_BACKUPS" ]; then
  # 查找并删除最旧的备份文件
  OLDEST_BACKUP=$(ls -t "$BACKUP_DIR" | grep "crontab_backup_" | tail -n 1)
  echo "Deleting old backup: $OLDEST_BACKUP"
  rm "$BACKUP_DIR/$OLDEST_BACKUP"
fi

# 导出当前的 crontab 配置到备份文件
crontab -l > "$BACKUP_FILE"

# 输出备份成功信息
echo "Crontab has been backed up to $BACKUP_FILE"
