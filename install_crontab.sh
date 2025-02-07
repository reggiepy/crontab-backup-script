#!/bin/bash

# 定义定时任务调度表达式
cron_schedule="*/5 * * * *"

# 定义脚本路径
script_path="/bin/bash /root/crontab-backup-script/crontab-backup-script.sh"

# 定义完整的定时任务命令
cron_job="$cron_schedule $script_path"

# 检查 crontab 中是否已经存在该脚本路径
(crontab -l 2>/dev/null | grep -F "$script_path") > /dev/null

# 如果 crontab 中已经包含该任务，则不做任何操作
if [ $? -eq 0 ]; then
    echo "定时任务已存在，跳过添加。"
else
    # 否则将任务追加到 crontab
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
    echo "定时任务已添加。"
fi

