grep -v '^AB0' prune_abcd_merge_1kg_pc.eigenvec|grep EUR|sort -gk3|head -n 1|awk '{print $3,$4}' >xy1
grep -v '^AB0' prune_abcd_merge_1kg_pc.eigenvec|grep EUR|sort -gk 4|head -n 1|awk '{print $3,$4}' > xy2
paste xy1 xy2|awk '$5=$4-$2;$6=$3-$1;$7=$5/$6' |awk 'NR==3'|awk '$8=$2-$1*$7{print $7,$8}' > k_b
                  
