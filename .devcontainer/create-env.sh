#!/bin/zsh

# init conda
conda init zsh

# source .zshrc to activate conda
source $HOME/.zshrc

# keep a copy of current working directory
cwd=$(pwd)

# define the environment name e.g. "esm2", "wwpdb", etc.
envname=dlpacker

# if conda env doesn't exist, create it
conda env list | grep -q $envname || conda create -n $envname python=3.10 -y && conda activate $envname

# if its environment config file exists, install it from config else build from scratch
if [ -f "${envname}-environment.yaml" ]; then
    conda env update --file "${envname}-environment.yaml" --name $envname
else
    # ****************************************************************
    # CUSTOM PACKAGES
    # Change this section according to your needs, two types of packages can be installed:
    # 1. conda/pip packages
    # 2. custom packages: COPY from host machine to container
    # ****************************************************************
    # install pytorch 2.1.1
    conda install -c pytorch -c nvidia -y pytorch=2.1.1 torchvision torchaudio pytorch-cuda=12.1

    # install other packages
    pip install gdown
    # ****************************************************************
fi

# save a copy to "${envname}-environment.yaml"
conda env export --name $envname --no-builds > /home/vscode/"${envname}-environment.yaml"

# cleanup
conda clean -a -y && \
pip cache purge && \
sudo apt autoremove -y
