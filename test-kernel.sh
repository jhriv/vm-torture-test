#!/bin/sh

kernel_version=4.4.44
kernel_tarfile=linux-"$kernel_version".tar.xz
kernel_sha1="a1723f60d217e7a11e33d214270a54ab5cf88261  $kernel_tarfile"
run_time="${RUNTIME:-3600}"
cores="${CORES:-$(nproc)}"

OS="${OS:-$(lsb_release --short --id)}"

download_kernel() {
  printf 'Downloading %s\n' "$kernel_tarfile"
  curl -o "$kernel_tarfile" https://cdn.kernel.org/pub/linux/kernel/v4.x/"$kernel_tarfile"
}

if [ -f "$kernel_tarfile" ]; then
  echo "$kernel_sha1" | sha1sum -c \
    || download_kernel
else
  download_kernel
fi

if [ ! -d linux-"$kernel_version" ]; then
  printf 'Extracting Kernel Sources\n'
  tar -xJf "$kernel_tarfile"
fi
cd linux-"$kernel_version"

# Start

printf 'Building for %s seconds with %s simultaneous jobs.\n' $run_time $cores

i=0
now=0
start_time=$(date +%s)
end_time=$(date +%s --date=@$(( start_time + run_time )))
previous=$start_time

while [ $now -lt $end_time ]; do
  i=$(( i + 1 ))
  printf 'Build #%s ...' $i
  make --silent --jobs=$cores O=run-$i i386_defconfig vmlinux modules
  now=$(date +%s)
  printf ' done. (%4s %+4d)\n' $(( now - start_time )) $(( now - previous ))
  previous=$now
done

printf 'Done.\n'
format_string='%-10s %-10s\n'
time_format='%H:%M:%S'
printf "\n$format_string$format_string\n$format_string$format_string" \
 "Start:" "End:" \
  $(date --date=@$start_time +"$time_format") \
  $(date --date=@$now +"$time_format") \
  "Compiles:"  "Overtime:" \
  $i \
  "+$(( now - end_time ))"
