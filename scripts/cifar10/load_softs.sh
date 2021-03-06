DATASET=cifar10
DATA_ROOT='~/datasets/CIFAR10'
ARCH=resnet34
LR=0.1
LR_SCHEDULE='cosine'
EPOCHS=200
BATCH_SIZE=256
LOSS=sat
ALPHA=0.9
ES=60
NOISE_RATE=0.0
NOISE_TYPE='corrupted_label'
TRAIN_SETS='trainval'
VAL_SETS='test_set'
EXP_NAME=${DATASET}/${ARCH}_${LOSS}_${NOISE_TYPE}_r${NOISE_RATE}_m${ALPHA}_p${ES}_${LR_SCHEDULE}_$1
SAVE_DIR=ckpts/${EXP_NAME}
LOG_FILE=logs/${EXP_NAME}.log
GPU_ID='0'

### print info
echo ${EXP_NAME}
mkdir -p ckpts
mkdir -p logs
mkdir -p logs/${DATASET}


### train
CUDA_VISIBLE_DEVICES=${GPU_ID} \
python -u loadsofts.py --arch ${ARCH} --loss ${LOSS} \
        --sat-alpha ${ALPHA} --sat-es ${ES} \
        --dataset ${DATASET} --data-root ${DATA_ROOT} \
        --noise-rate ${NOISE_RATE} --noise-type ${NOISE_TYPE} \
        --lr ${LR} --lr-schedule ${LR_SCHEDULE} \
        --train-sets ${TRAIN_SETS} --val-sets ${VAL_SETS} \
        --batch-size ${BATCH_SIZE} --epochs ${EPOCHS} \
        --save-dir ${SAVE_DIR}
