#!/bin/bash
#SBATCH --job-name=ssl-prov_reproduce-empirical-2_seed-0
#SBATCH --output=ssl-prov_reproduce-empirical-2_seed-0.out
#SBATCH --ntasks=1
#SBATCH --time=96:00:00
#SBATCH --mem=48Gb
#SBATCH -c 12
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --partition=long

module purge
module load cuda/11.2/cudnn/8.1 anaconda/3

conda activate ssl_identifiability
cd /home/mila/h/horoiste/ssl_identifiability

python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-color-distortion
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-color-distortion --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'small'
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'small' --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'large'
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'large' --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'small' --apply-color-distortion
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'small' --apply-color-distortion --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'large' --apply-color-distortion
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-random-crop --random-crop-type 'large' --apply-color-distortion --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-rotation
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-rotation --evaluate
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-rotation --apply-color-distortion
python main_3dident.py --offline-dataset 'data' --seed 0 --workers 8 --apply-rotation --apply-color-distortion --evaluate

conda deactivate
