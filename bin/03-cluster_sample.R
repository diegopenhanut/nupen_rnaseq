
library(WGCNA)
library(data.table)

options(stringsAsFactors = FALSE);
enableWGCNAThreads()

datExpr0 <- fread("../dados/BRCA.exp.547.med.txt",
		      sep = "\t")

genes <- datExpr0$NAME

datExpr0$NAME <- NULL

rownames(datExpr0) <- genes

datExpr0 <- t(datExpr0)

colnames(datExpr0) <- genes

gsg = goodSamplesGenes(datExpr0, verbose = 3);
gsg$allOK


sampleTree = hclust(dist(datExpr0), method = "average");
# Plot the sample tree: Open a graphic output window of size 12 by 9 inches
# The user should change the dimensions if the window is too large or too small.
sizeGrWindow(12,9)
#pdf(file = "Plots/sampleClustering.pdf", width = 12, height = 9);
par(cex = 0.6);
par(mar = c(0,4,2,0))
plot(sampleTree, main = "Sample clustering to detect outliers", sub="", xlab="", cex.lab = 1.5,
cex.axis = 1.5, cex.main = 2)

traitData <- read.table("../dados/BRCA.datafreeze.20120227.txt",
		       sep = "\t",
		       header = T)

traitData <- traitData[,c(1, 3, 4, 5, 7)]
head(traitData)

samples <- rownames(datExpr0);
head(samples)
samples <- sapply(samples,
 function(a){
 sp <- strsplit(x=a, split="-")[[1]][1:4]
out <- paste(unlist(sp), collapse = "-")
out
 
  }
)
head(samples)

traitRows <- match(samples, traitData$Sample);
datTraits <- traitData[traitRows, -1];
datTraits <- as.data.frame(lapply(datTraits, 
	function(a){
		as.numeric(as.factor(a))
	}
))
head(datTraits)
str(datTraits)
rownames(datTraits) <- traitData[traitRows, 1];
collectGarbage();

# Re-cluster samples
sampleTree2 = hclust(dist(datExpr0), method = "average")
# Convert traits to a color representation: white means low, red means high, grey means missing entry
traitColors = numbers2colors(datTraits, signed = FALSE); 
# Plot the sample dendrogram and the colors underneath.

png("../output/dendogram.samples.png")
plotDendroAndColors(sampleTree2, traitColors,
		    groupLabels = names(datTraits),
		    main = "Sample dendrogram and trait heatmap")
dev.off()
