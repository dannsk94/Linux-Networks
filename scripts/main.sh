#!/bin/bash

start_time=$(date +%s.%N)

if [[ -z "$1" || "$1" != */ ]]; then
  echo "Ошибка: Укажите путь, заканчивающийся знаком '/', например: $0 /var/log/"
  exit 1
fi

. ./logic.sh
analyze_dir "$1"

end_time=$(date +%s.%N)
diff=$(echo "$end_time - $start_time" | bc)
printf "Script execution time (in seconds) = %.1f\n" "$diff"
