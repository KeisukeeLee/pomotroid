#!/bin/bash

# 遍历当前目录中所有以 mixkit 开头的 .wav 文件
for file in mixkit*.wav
do
  # 检查文件是否存在
  if [[ -f "$file" ]]; then
    # 提取文件名（去掉扩展名）
    filename="${file%.wav}"
    
    # 使用 FFmpeg 将 WAV 转换为 MP3
    ffmpeg -i "$file" -codec:a libmp3lame -qscale:a 2 "${filename}.mp3"
    
    echo "转换完成: $file -> ${filename}.mp3"
  else
    echo "未找到匹配的文件: $file"
  fi
done

