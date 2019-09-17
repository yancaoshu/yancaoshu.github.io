rm alle.txt
for dir in `cat the_num_of_df_mbj1nospin.txt | awk '{print $1}'`
do
echo $dir >>../alle.txt
cd $dir
cd Elastic
rm -r NUM
mkdir NUM
for num in  5 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150
do
echo "$num" >>NUM/e.txt
tail -n 3 ELACON_strainmode$num | head -n 1 >>NUM/e.txt
done
sed -i 'N;s/\n/ /g' NUM/e.txt
sed -i 's/=/ /g' NUM/e.txt
awk '{print $3,$5,$7}' NUM/e.txt >NUM/e
sort -n NUM/e >NUM/sor.txt
sed -i '/*/d' NUM/sor.txt
sed -i '/^$/d' NUM/sor.txt   #这一步一定要
a=`head -n 1 NUM/sor.txt | awk '{print $1}'`
b=`grep "$a" NUM/e.txt | awk '{print $1}' `
#rm ELACON
cp ELACON_strainmode$b ELACON
for T in 700
do
echo -e "5\n$T" >c.txt
cij2kl <c.txt
done
cat NUM/sor.txt >>../../alle.txt
cd ../../
done
