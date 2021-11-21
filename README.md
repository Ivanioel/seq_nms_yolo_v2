# Seq_nms_YOLO

#### Membres: Yunyun SUN, Yutong YAN, Sixiang XU, Heng ZHANG

---

## Introduction


This project combines **YOLOv2**([reference](https://arxiv.org/abs/1506.02640)) and **seq-nms**([reference](https://arxiv.org/abs/1602.08465)) to realise **real time video detection**.

## Steps

1. Clone the github repository in the folder you would like to have the project:
```
git clone https://github.com/Ivanioel/seq_nms_yolo_v2
```
2. Go inside the project: 
```
cd seq_nms_yolo_v2
```

3. Make your proyect using the command `make`.
    * Take into consideration that there are some flags you should change depending on your environment.
    * GPU=1 # 0 if your pc doesn't support CUDA - If you are going to execute in GPU be sure that the variables `COMMON` and `LDFLAGS` are pointing to your cuda installation folder. In this case they are pointing to `/usr/local/cuda-10.1/`
    * CUDNN=0 # 1 if your pc does support CUDNN
    * OPENCV=0 # 1 if your pc does support OPENCV


4. Download `yolo.weights` and `tiny-yolo.weights` by running:
```
wget https://pjreddie.com/media/files/yolo.weights
wget https://pjreddie.com/media/files/yolov2-tiny.weights
```
5. Create your conda environment and install all the packages required (you have to activate conda first with `conda init`. For more info https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html):
```
conda create -y -p ./env python=2.7
conda activate ./env

pip install --upgrade tensorflow tf_object_detection
conda install -y opencv matplotlib pillow scipy
```

6. Change the path of `PKG_CONFIG_PATH` (an environment variable that specifies additional paths in which `pkg-config` will search for its .pc files):

```
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$(pwd)/env/lib/pkgconfig
export PKG_CONFIG_PATH
```

7. Copy the libdarknet object and link file in your conda environment:

```
cp libdarknet.so ./env/lib
cp libdarknet.a ./env/lib
```

8. Move to the video folder by `cd video`.

9. Copy a video file to the video folder, for example, `input.mp4`

10. In the video folder run:
```
python video2img.py -i input.mp4
python get_pkllist.py
```

11. Return to project root floder (`cd ..`) and run `python yolo_seqnms.py` to generate output images in the `video/output` folder.

12. If you want to reconstruct a video from these output images, you can go to the video folder and run `python img2video.py -i output`

And you will see detection results in `video/output`

13. (Extra) If you want to try with different videos and with seq-nms and only nms, execute `execute_all.sh` in the video folder (giving it execution permission with `chmod +x execute_all.sh`) and all the sample videos in the video folder will be used.

## Reference

This project copies lots of code from [darknet](https://github.com/pjreddie/darknet) , [Seq-NMS](https://github.com/lrghust/Seq-NMS) and  [models](https://github.com/tensorflow/models).
