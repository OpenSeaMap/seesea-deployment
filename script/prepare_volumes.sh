#!/bin/bash

# create directories for pgadmin
if [ ! -d "./volumes/pgadmin" ]; then
    echo "Directory ./volumes/pgadmin does not exist. Creating it..."
    sudo mkdir -p ./volumes/pgadmin
    sudo chown 5050:0 ./volumes/pgadmin
    sudo chmod a+rwx ./volumes/pgadmin -R
else
    echo "Directory ./volumes/pgadmin already exists."
fi

if [ ! -d "./volumes/postprocess/app" ]; then
    echo "Directory ./volumes/postprocess/app does not exist. Creating it..."
    sudo mkdir -p ./volumes/postprocess/app 
    sudo chmod a+rw volumes/postprocess/app 
else
    echo "Directory ./volumes/postprocess/app already exists."
fi

if [ ! -d "./volumes/postprocess/rawdata" ]; then
    echo "Directory ./volumes/postprocess/rawdata does not exist. Creating it..."
    sudo mkdir -p ./volumes/postprocess/rawdata 
    sudo chmod a+rw volumes/postprocess/rawdata 
else
    echo "Directory ./volumes/postprocess/rawdata already exists."
fi


if [ ! -d "./volumes/postprocess/seesea" ]; then
    sudo chmod a+rw volumes/postprocess -R
    git clone https://github.com/OpenSeaMap/seesea  ./volumes/postprocess/seesea
else
    echo "Directory ./volumes/postprocess/seesea already exists."
fi


URL="https://depth.openseamap.org/p2/res/tidalConsituents.txt.gz"
DEST_DIR="./volumes/postprocess/seesea/net.sf.seesea.tidemodel.dtu10.java/res"
FILE_NAME="tidalConsituents.txt.gz"

if [ ! -f "$DEST_DIR/$FILE_NAME" ]; then
    echo "Downloading $URL to $DEST_DIR/$FILE_NAME..."
    curl -o "$DEST_DIR/$FILE_NAME" "$URL"

else
    echo "Skip download of file $DEST_DIR/$FILE_NAME."
fi
