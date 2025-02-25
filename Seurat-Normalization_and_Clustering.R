#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="LungCancer_FFPE"
min_counts = 0
XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

#sampleID="LungCancer_FFPE"
#min_counts = 20
#XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

#sampleID="LungCancer_FFPE"
#min_counts = 40
#XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

#sampleID="LungCancer_FFPE"
#min_counts = 80
#XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

library(Seurat)
library(ggplot2)

output_name = paste(sampleID,"-mincount",min_counts,"-SeuratNorm",sep="")

#follow example code : https://satijalab.org/seurat/articles/seurat5_spatial_vignette_2#mouse-brain-10x-genomics-xenium-in-situ
#FOV = Field of View --> https://www.10xgenomics.com/support/software/xenium-onboard-analysis/latest/analysis/xoa-output-understanding-outputs

xenium.obj = LoadXenium(XeniumRanger_outs, fov = "fov")
print(ncol(xenium.obj))
xenium.obj = subset(xenium.obj, subset = nCount_Xenium > min_counts)
print(ncol(xenium.obj))

xenium.obj = SCTransform(xenium.obj, assay = "Xenium")
xenium.obj = RunPCA(xenium.obj, npcs = 30, features = rownames(xenium.obj))
xenium.obj = RunUMAP(xenium.obj, dims = 1:30)
xenium.obj = FindNeighbors(xenium.obj, reduction = "pca", dims = 1:30)
xenium.obj = FindClusters(xenium.obj, resolution = 0.3)

#information saved within `xenium.obj@meta.data`

ImageDimPlot(xenium.obj, group.by = "seurat_clusters", size = 1.5, cols = "polychrome",
    dark.background = F, nmols = 20000, fov = "fov")
ggsave(paste(output_name,"-ImagePlot_SeuratClusters.png",sep=""))
