a<-read.table("/Users/apple/Downloads/ABCD_ADHD/results/pca/merge_eur1_1kg_pca.eigenvec",header=F)

g1kplotpch = c(rep(21,?),rep(2,96),rep(1,61),rep(0,86),rep(0,93),rep(0,99),rep(1,103),
               rep(2,105),rep(0,94),rep(2,99),rep(1,99),rep(2,91),rep(1,103),
               rep(3,113),rep(3,107),rep(4,102),rep(3,104),rep(4,99),rep(0,99),rep(1,85),
               rep(1,64),rep(2,85),rep(3,96),rep(3,104),rep(2,102),rep(4,107),rep(0,108))

g1kplotcol = c(rep("black",?),rep("#ed194198",96),rep("#ed194198",61),rep("grey",86),rep("#27342b98",93),rep("#009ad698",99),rep("#27342b98",103),
               rep("#27342b98",105),rep("#1d953f98",94),rep("#ed194198",99),rep("#009ad698",99),rep("#009ad698",91),rep("grey",103),
               rep("#ed194198",113),rep("#009ad698",107),rep("grey",102),rep("#27342b98",104),rep("#27342b98",99),rep("#ed194198",99),rep("#ed194198",85),
               rep("#1d953f98",64),rep("#1d953f98",85),rep("grey",96),rep("#1d953f98",104),rep("grey",102),rep("#009ad698",107),rep("#ed194198",108))

g1klegendpch = c(21,rep(9,7),
                 1,2,3,2,0,1,0,rep(9,1),
                 2,3,1,0,rep(9,4),
                 4,0,2,1,3,rep(9,3),
                 0,2,4,1,3,rep(9,3),
                 0,1,4,3,2,rep(9,3))

g1klegendcol = c(rep("black",1),rep("#f0000000",7),
                 "#ed1941","#ed1941","#ed1941","#ed1941","#ed1941","#ed1941","#ed1941",rep("#f0000000",1),
                 "#1d953f","#1d953f","#1d953f","#1d953f",rep("#f0000000",4),
                 "#27342b","#27342b","#27342b","#27342b","#27342b",rep("#f0000000",3),
                 "#009ad6","#009ad6","#009ad6","#009ad6","#009ad6",rep("#f0000000",3),
                 "grey","grey","grey","grey","grey",rep("#f0000000",3))

g1klegendchr = c("ABCD",rep("",7),
                 "MSL","ACB","GWD","ESN","YRI","ASW","LWK",rep("",1),
                 "PEL","PUR","MXL","CLM",rep("",4),
                 "KHV","CDX","CHS","CHB","JPT",rep("",3),
                 "CEU","GBR","TSI","FIN","IBS",rep("",3),
                 "BEB","GIH","ITU","PJL","STU",rep("",3))

pdf(file="/Users/apple/Downloads/ABCD_ADHD/results/merge_eur_intersept_1kg.eigenvec_p12.pdf")
par(mar=c(7,7,6,6))
plot(a$V3,a$V4,cex=c(rep(1,?),1.3),lwd=0.8,
     bg="#fcaf17",pch=g1kplotpch,col=g1kplotcol,xlab="PC1",ylab="PC2",xlim=c(-.03,.02),ylim=c(-.04,.04))
legend("bottomright",ncol=6,cex=.7,pt.lwd=c(1,rep(1.5,47)),inset=c(0,0),
       pt.bg="#fcaf17",bty="n",g1klegendchr,pch=g1klegendpch,col=g1klegendcol)

dev.off()

pdf(file="/Users/apple/Downloads/ABCD_ADHD/results/merge_eur_intersept_1kg.eigenvec_p32.pdf")
par(mar=c(7,7,6,6))
plot(a$V5,a$V4,cex=c(rep(1,?),1.3),lwd=1,
     bg="#fcaf17",pch=g1kplotpch,col=g1kplotcol,xlab="PC3",ylab="PC2",xlim=c(-.04,.02),ylim=c(-.08,.025))
#xlim=c(-.21,.08), ylim=c(-.112,.05)
legend("bottomleft",ncol=6,cex=.7,pt.lwd=c(1,rep(1.5,47)),inset=c(0,0), 
       pt.bg="#fcaf17",bty="n",g1klegendchr,pch=g1klegendpch,col=g1klegendcol)
#,text.width=0.014
#text(cex=1,a$V5[2535],a$V4[2535]-.005,labels=c("Sardinia"))
dev.off()
