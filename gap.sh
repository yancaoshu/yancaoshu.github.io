rm the_num_of_gap_mbj*.txt
for dir in `cat shoulian.txt`
do
cd $dir
cd Bandmbj_nospin/test_scan
getgap
gap=`tail -1 gap.txt | awk '{print $4}' `
if ((`echo "$gap>0.1" | bc `))
then
echo " $gap $dir" >>../../../the_num_of_gap_mbj1nospin.txt
else
echo "$gap $dir" >>../../../the_num_of_gap_mbj0nospin.txt
fi
cd ../../../
done
#sed -i 'N;s/\n/ /g' the_num_of_gap_mbj.txt
