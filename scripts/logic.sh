#!/bin/bash

analyze_dir() {
  path=$1

  echo "Total number of folders (including all nested ones) = $(find "$path" -mindepth 1 -type d | wc -l)"
  
  echo "TOP 5 folders of maximum size arranged in descending order (path and size):"

  du -h "$path" 2>/dev/null | sort -rh | head -n 5 | awk '{print NR " - " $2 "/", $1}'
  
  echo "Total number of files = $(find "$path" -type f | wc -l)"
  
  echo "Number of:"

  echo "Configuration files (with the .conf extension) = $(find "$path" -type f -name "*.conf" | wc -l)"
  echo "Text files = $(find "$path" -type f -name "*.txt" | wc -l)"
  echo "Executable files = $(find "$path" -type f -executable | wc -l)"
  echo "Log files (with the extension .log) = $(find "$path" -type f -name "*.log" | wc -l)"
  echo "Archive files = $(find "$path" -type f -name "*.zip" -o -name "*.tar" -o -name "*.gz" | wc -l)"
  echo "Symbolic links = $(find "$path" -type l | wc -l)"

  echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"

  find "$path" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | awk -F. '{split($0, a, " "); printf "%d - %s, %s, %s\n", NR, a[2], a[1], $NF}'

  echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash):"

  find "$path" -type f -executable -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}'
}
