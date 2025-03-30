# EMFS: Minimising redundancy, maximising relevance: efficient memory feature selection for video object segmentation


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

| Method            |        J_tr        |        J      |                                  |
| ----------------- | ------------------ | ------------- | -------------------------------- |
| AOT*              | 39.0               | 50.4          | ./aot_plus/pretrain_models/R50_AOTL.pth |
| AOT* + EMFS       | 42.8               | 51.6          | ./aot_plus/pretrain_models/AOT_EMFS.pth  |
| DeAOT*            | 39.5               | 51.7          | ./aot_plus/pretrain_models/R50_DeAOTL.pth   |
| DeAOT* + EMFS     | 41.9               | 52.6          | ./aot_plus/pretrain_models/DeAOT_EMFS.pth |

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
