#!/bin/bash

curr_fdr=$(pwd)
echo "enter the full path of the source folder (ex.  /mnt/sda1/ )"
read folder
echo "enter the full path of the output folder"
read output

if [ ! -d $folder ]
then
    echo "$folder does not exist...exiting"
    exit 1
fi

if [ ! -d $output ]
then
    echo "$output does not exit...trying to create it"
    sudo mkdir $output
fi

echo "the following files will be converted:"

file_counter=0
cd $folder
for file in *.mp4
do
     file_counter=$(($file_counter+1))
     ffmpeg -v verbose -hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD128  -i "$file" -c:v hevc_vaapi -preset medium -global_quality 25 -c:a aac -map_metadata 0:s:0 "$output${file}"
done

echo "$file_counter files are converted successfully"
cd $curr_fdr

exit 0
