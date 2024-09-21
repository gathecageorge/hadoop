#!/bin/bash
set -ex

# Start jupyter
jupyter notebook --notebook-dir=/home/hadoop/notebooks --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
