#!/bin/bash
video_files=("v_ApplyEyeMakeup_g19_c03.avi" "v_Archery_g07_c01.avi" "v_BalanceBeam_g18_c01.avi" "v_ApplyLipstick_g21_c01.avi" "v_BabyCrawling_g11_c01.avi")
 
# Iterate the string array using for loop
for video in ${video_files[@]}; do
    video_no_ext=${video::-4}
    echo "Executing steps for $video_no_ext"
    
    python video2img.py -i $video
    python get_pkllist.py

    mkdir $video_no_ext
    cd ..
    python yolo_seqnms.py
    cd video/
    python img2video.py -i output
    mv output.mp4 $video_no_ext/output_seqnms.mp4
    mv output $video_no_ext/output_seqnms

    cd ..
    python yolo_Ses2.py
    cd video/
    python img2video.py -i output
    mv output.mp4 $video_no_ext/output_nms.mp4
    mv output $video_no_ext/output_nms

    rm input/*
done