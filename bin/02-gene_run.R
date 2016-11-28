library(WGCNA)
library(data.table)

options(stringsAsFactors = FALSE);
enableWGCNAThreads()

datExpr <- fread("../dados/BRCA.exp.547.med.txt",
		      sep = "\t")

genes <- datExpr$NAME

datExpr$NAME <- NULL

rownames(datExpr) <- genes

t_datExpr <- t(datExpr)

colnames(t_datExpr) <- genes

head(t_datExpr)

net <- blockwiseModules(t_datExpr, power = 6,
                       TOMType = "unsigned", minModuleSize = 30,
                       reassignThreshold = 0, mergeCutHeight = 0.25,
                       numericLabels = TRUE, pamRespectsDendro = FALSE,
                       saveTOMs = TRUE,
                       saveTOMFileBase = "../output/gene_BRCA_TCGA_TOM", 
                       verbose = 3)

# open a graphics window
# sizeGrWindow(12, 9)
# Convert labels to colors for plotting
mergedColors = labels2colors(net$colors)
# Plot the dendrogram and the module colors underneath

svg(filename = "../output/gene_dendograma.svg",
    width = 12,
    height = 9)

plotDendroAndColors(net$dendrograms[[1]], mergedColors[net$blockGenes[[1]]],
                    "Module colors",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05)

dev.off()

moduleLabels = net$colors
moduleColors = labels2colors(net$colors)
MEs = net$MEs;
geneTree = net$dendrograms[[1]];
save(MEs, moduleLabels, moduleColors, geneTree, 
     file = "../output/gene_BRCA_TCGA-networkConstruction-auto.RData")

geneTree
head(MEs)

mc <- unique(moduleColors)

##
table(net$colors)

