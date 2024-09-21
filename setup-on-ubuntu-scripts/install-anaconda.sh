# Set variables
ARG_CURRENT_USER=$1
ARG_SCRIPT_DIR=$2
CLEAN_UP="${3:-no}"

TO_INSTALL="curl libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6"
source $ARG_SCRIPT_DIR/install-packages.sh $CLEAN_UP

# Get anaconda
curl -O https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
bash Anaconda3-2024.06-1-Linux-x86_64.sh -b -p ./Anaconda
eval "$(./Anaconda/bin/conda shell.bash hook)"
conda init
rm Anaconda3-2024.06-1-Linux-x86_64.sh

conda install jupyter -y --quiet
conda install openjdk -y --quiet
conda install pyspark -y --quiet
conda install -c conda-forge findspark -y --quiet

mkdir -p ./notebooks
