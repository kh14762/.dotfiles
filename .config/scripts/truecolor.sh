#!/usr/bin/env bash

echo "24-bit True Color Test"
echo

for r in 0 95 135 175 215 255; do
  for g in 0 95 135 175 215 255; do
    printf "\x1b[48;2;%d;%d;0m " "$r" "$g"
  done
  printf "\x1b[0m\n"
done

echo
echo "Gradient Test:"
for i in $(seq 0 255); do
  printf "\x1b[48;2;%d;100;%dm " "$i" "$((255 - i))"
done
printf "\x1b[0m\n\n"

echo "RGB Color Ramp:"
for i in $(seq 0 255); do
  printf "\x1b[38;2;%d;%d;%dm█" "$i" 128 "$((255 - i))"
done
printf "\x1b[0m\n"

#!/usr/bin/env bash

echo "24-bit True Color Test"
echo

for r in 0 95 135 175 215 255; do
  for g in 0 95 135 175 215 255; do
    printf "\x1b[48;2;%d;%d;0m " "$r" "$g"
  done
  printf "\x1b[0m\n"
done

echo
echo "Gradient Test:"
for i in $(seq 0 255); do
  printf "\x1b[48;2;%d;100;%dm " "$i" "$((255 - i))"
done
printf "\x1b[0m\n\n"

echo "RGB Color Ramp:"
for i in $(seq 0 255); do
  printf "\x1b[38;2;%d;%d;%dm█" "$i" 128 "$((255 - i))"
done
printf "\x1b[0m\n\n"

echo "AWK Rainbow Test:"
awk 'BEGIN{
    s="/\\/\\/\\\\";
    for (colnum = 0; colnum < 77; colnum++) {
        r = 255 - (colnum * 255 / 76);
        g = (colnum * 510 / 76);
        b = (colnum * 255 / 76);
        if (g > 255) g = 510 - g;
        printf "\033[48;2;%d;%d;%dm", r, g, b;
        printf "\033[38;2;%d;%d;%dm", 255-r, 255-g, 255-b;
        printf "%s\033[0m", substr(s, (colnum % 4) + 1, 1);
    }
    printf "\n";
}'
