#!/bin/bash
#SBATCH --job-name=test_emp2
#SBATCH --output=test_emp2.out
#SBATCH --ntasks=1
#SBATCH --time=96:00:00
#SBATCH --mem=32Gb
#SBATCH -c 8
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --partition=long

module purge
module load cuda/11.2/cudnn/8.1 anaconda/3

conda activate ssl_identifiability
cd /home/mila/h/horoiste/ssl_identifiability

python main_3dident.py --offline-dataset 'data' --seed 0 --apply-random-crop --random-crop-type 'small' --apply-color-distortion --workers 4

conda deactivate
