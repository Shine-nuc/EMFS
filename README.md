# An Efficient Plug-and-Play Enhancement for Robust Video Object Segmentation via Relevance–Redundancy Memory Update (ERMU) 


## Data preparation

Download the VOST dataset from [vostdataset.org](https://www.vostdataset.org/) , and organize the directory structure as follows:

```bash
├── aot_plus
│   ├── configs
│   ├── dataloaders
│   ├── datasets
│   │   └── VOST
│   │       ├── Annotations
│   │       ├── ImageSets
│   │       ├── JPEGImages
│   │       └── JPEGImages_10fps
│   ├── docker
│   ├── networks
│   ├── pretrain_models
│   └── tools
├── evaluation
└── README.md
```

> hint: you can achieve it by soft link:
> ```bash
> ln -s <your VOST directory>  ./datasets/VOST
> ```

## Checkpoint

Download the checkpoint and put them in `./aot_plus/pretrain_models/`

| Method        | J_tr | J    |                                                              |
| ------------- | ---- | ---- | ------------------------------------------------------------ |
| AOT*          | 39.0 | 50.4 | [R50_AOTL.pth](https://drive.google.com/file/d/1kZgtsdZGRdWxQ4_taAS6C_NGDcn9ufYi/view?usp=drive_link) |
| AOT* + EMFS   | 42.8 | 51.6 | [AOT_EMFS.pth](https://drive.google.com/file/d/16geEhjPXVTqy0guwODaqi96JAOcgaA6Z/view?usp=drive_link) |
| DeAOT*        | 39.5 | 51.7 | [R50_DeAOTL.pth](https://drive.google.com/file/d/1PY8Ns8X-V24eiklifgVcdiAC748IIWCJ/view?usp=drive_link) |
| DeAOT* + EMFS | 41.9 | 52.6 | [DeAOT_EMFS.pth](https://drive.google.com/file/d/1Y16_Ef2kJIhZrUSc7tdp6mYlnVpEezVJ/view?usp=drive_link) |

The * denotes our implementation with constrained memory bank capacity and a fixed strategy of removing the first frame during updates.



## Evaluation

Firstly prepare the pytorch environment. Please follow the instructions on [pytorch.org](https://pytorch.org/) and choose the pytorch version that is most compatible with your machine.

Then
```bash
conda install numpy matplotlib scipy scikit-learn tqdm pyyaml pandas
pip install opencv-python timm
```

Now you can replicate the result of our checkpoint.
```bash
cd ./aot_plus
./eval_vost.sh
```

If you want to evaluate DeAOT, please modify the `eval_vost.sh`, change `model` to `r50_deaotl` and change `ckpt_path` to `DeAOT_EMFS.pth`.

## Training

If you want to train your own model, you can train it from the AOT/DeAOT model (pretrained on DAVIS and YouTubeVOS) provided by the official AOT team. The models can be accessed from the [MODEL_ZOO](https://github.com/yoxu515/aot-benchmark/blob/main/MODEL_ZOO.md)


Then
```bash
cd ./aot_plus
./train_vost.sh
```
