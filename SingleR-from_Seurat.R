#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="LungCancer_FFPE"
min_counts = 0
preprocess=TRUE
XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

#sampleID="LungCancer_FFPE"
#min_counts = 0
#preprocess=FALSE
#XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

#sampleID="LungCancer_FFPE"
#min_counts = 20
#preprocess=FALSE
#XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

library(Seurat)
library(ggplot2)
library(SingleR)
library(celldex)

if(preprocess){
	output_name = paste(sampleID,"-mincount",min_counts,"-SeuratNorm",sep="")
}else{
	output_name = paste(sampleID,"-mincount",min_counts,"-NoNorm",sep="")
}


#follow example code : https://satijalab.org/seurat/articles/seurat5_spatial_vignette_2#mouse-brain-10x-genomics-xenium-in-situ

xenium.obj = LoadXenium(XeniumRanger_outs, fov = "fov")
print(ncol(xenium.obj))
xenium.obj = subset(xenium.obj, subset = nCount_Xenium > min_counts)
print(ncol(xenium.obj))

#it is **much** quicker if you skip these steps, but I thought it would be good to keep for reference (since they are mentioned in the example, even though that uses RCTD instead of SingleR)
if(preprocess){
	xenium.obj = SCTransform(xenium.obj, assay = "Xenium")
	xenium.obj = RunPCA(xenium.obj, npcs = 30, features = rownames(xenium.obj))
	xenium.obj = RunUMAP(xenium.obj, dims = 1:30)
	xenium.obj = FindNeighbors(xenium.obj, reduction = "pca", dims = 1:30)
	xenium.obj = FindClusters(xenium.obj, resolution = 0.3)
}#end if(preprocess)

#roughly follow SingleR example : https://www.bioconductor.org/packages/release/bioc/vignettes/SingleR/inst/doc/SingleR.html
#I also have some experience from a rotation project (but not for spatial data), which was partially used as a template.
hpca.se = HumanPrimaryCellAtlasData()
blueprint.ENCODE = BlueprintEncodeData()

expr = GetAssayData(xenium.obj)

SingleR_result.HPCA = SingleR(test = expr, ref = hpca.se, 
								labels = hpca.se$label.main)
write.csv(data.frame(cell=rownames(SingleR_result.HPCA), SingleR_result.HPCA),
				paste(output_name,"-Seurat_import-SingleR_HPCA.csv",sep=""),
				row.names=FALSE, quote=F)
								
SingleR_result.blueprint_ENCODE = SingleR(test = expr, ref = blueprint.ENCODE, 
								labels = blueprint.ENCODE$label.main)
write.csv(data.frame(cell=rownames(SingleR_result.blueprint_ENCODE), SingleR_result.blueprint_ENCODE),
				paste(output_name,"-Seurat_import-SingleR_blueprint.ENCODE.csv",sep=""),
				row.names=FALSE, quote=F)
								
#return to Seurat example for plotting annotations
	
#HPCA
xenium.obj$predicted.celltype.HPCA = SingleR_result.HPCA$pruned.labels

xenium.obj = BuildNicheAssay(object = xenium.obj, fov = "fov", group.by = "predicted.celltype.HPCA",
								niches.k = 5, neighbors.k = 30, cluster.name = "niches.HPCA")
celltype.plot = ImageDimPlot(xenium.obj, group.by = "predicted.celltype.HPCA", size = 1.5, cols = "polychrome",
    dark.background = F, nmols = 20000)) + ggtitle("Cell type")
niche.plot = ImageDimPlot(xenium.obj, group.by = "niches.HPCA", size = 1.5, dark.background = F) + ggtitle("Niches") +
    scale_fill_manual(values = c("#442288", "#6CA2EA", "#B5D33D", "#FED23F", "#EB7D5B"))
celltype.plot | niche.plot
ggsave(paste(output_name,"--Seurat_import-SingleR_HPCA-ImagePlot.png",sep=""))

#blueprint_ENCODE
xenium.obj$predicted.celltype.blueprint_ENCODE = SingleR_result.blueprint_ENCODE$pruned.labels

xenium.obj = BuildNicheAssay(object = xenium.obj, fov = "fov", group.by = "predicted.celltype.blueprint_ENCODE",
								niches.k = 5, neighbors.k = 30, cluster.name = "niches.blueprint_ENCODE")
								
celltype.plot = ImageDimPlot(xenium.obj, group.by = "predicted.celltype.blueprint_ENCODE", size = 1.5, cols = "polychrome",
    dark.background = F, nmols = 20000)) + ggtitle("Cell type")
niche.plot = ImageDimPlot(xenium.obj, group.by = "niches.blueprint_ENCODE", size = 1.5, dark.background = F) + ggtitle("Niches") +
    scale_fill_manual(values = c("#442288", "#6CA2EA", "#B5D33D", "#FED23F", "#EB7D5B"))
celltype.plot | niche.plot
ggsave(paste(output_name,"--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png",sep=""))