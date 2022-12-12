#!/bin/bash
#SBATCH --job-name=ssl-prov_reproduce-empirical-1
#SBATCH --output=ssl-prov_reproduce-empirical-1.out
#SBATCH --ntasks=1
#SBATCH --time=96:00:00
#SBATCH --mem=10Gb
#SBATCH -c 4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --partition=long

module purge
module load cuda/11.2/cudnn/8.1 anaconda/3

conda activate ssl_identifiability
cd /home/mila/h/horoiste/ssl_identifiability

for seed in 0 1 2; do
    python main_mlp.py --style-change-prob 1.0 --seed $seed
    python main_mlp.py --style-change-prob 1.0 --seed $seed --evaluate
    python main_mlp.py --style-change-prob 0.75 --seed $seed
    python main_mlp.py --style-change-prob 0.75 --seed $seed --evaluate
    python main_mlp.py --style-change-prob 0.75 --statistical-dependence --seed $seed
    python main_mlp.py --style-change-prob 0.75 --statistical-dependence --seed $seed --evaluate
    python main_mlp.py --style-change-prob 0.75 --statistical-dependence --content-dependent-style --seed $seed
    python main_mlp.py --style-change-prob 0.75 --statistical-dependence --content-dependent-style --seed $seed --evaluate
done
conda deactivate
