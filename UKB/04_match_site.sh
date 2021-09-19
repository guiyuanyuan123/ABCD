awk '{if($4!="NA") {$4=$4}if($4=="NA" && $5!="NA"){$4=$5};print}' site_54.tab |awk '$4!="NA"{print $1,$4}' > site_54
awk 'NR==FNR{a[$1]=$2;next}{if($1 in a)print $0,a[$1]}' site_54 ../21523_mismatch.fam |awk '$7=="11025"' > 11025_Cheadle/11025
awk 'NR==FNR{a[$1]=$2;next}{if($1 in a)print $0,a[$1]}' site_54 ../21523_mismatch.fam |awk '$7=="11027"' > 11027_Newcastle/11027
awk 'NR==FNR{a[$1]=$2;next}{if($1 in a)print $0,a[$1]}' site_54 ../21523_mismatch.fam |awk '$7=="11026" || $7=="11027"' > 11026_27_Reading_Newcastle/11026_11027
nohup /export/home/guiyuanyuan/tools/plink --bfile ../Merge_brain --keep 11025_Cheadle/11025 --make-bed --out 11025_Cheadle/11025
nohup /export/home/guiyuanyuan/tools/plink --bfile ../Merge_brain --keep 11027_Newcastle/11027 --make-bed --out 11027_Newcastle/11027

