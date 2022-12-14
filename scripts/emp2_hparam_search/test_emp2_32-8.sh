#!/bin/bash
#SBATCH --job-name=test_emp2_32-8
#SBATCH --output=test_emp2_32-8.out
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem=32Gb
#SBATCH -c 8
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --partition=long

module purge
module load cuda/11.2/cudnn/8.1 anaconda/3

conda activate ssl_identifiability
cd /home/mila/h/horoiste/ssl_identifiability

for workers in 0 2 4 8 16; do
    for batch_size in 128 256 512; do
        python main_3dident.py --offline-dataset 'data' --seed 0 --apply-random-crop --apply-color-distortion --n-steps 501 --workers $workers --batch-size $batch_size
    done
done

conda deactivate