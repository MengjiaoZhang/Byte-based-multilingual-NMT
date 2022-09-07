src=$1
tgt=$2
year=$3
echo "======= Creating raw data for ${src}-${tgt} ======="
bash create_iwslt_data.sh $src $tgt $year
echo "======= Done creating raw data for ${src}-${tgt} ======="