#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="LungCancer_FFPE"
XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

library(Seurat)
library(ggplot2)

#follow example code : https://satijalab.org/seurat/articles/seurat5_spatial_vignette_2#mouse-brain-10x-genomics-xenium-in-situ
#FOV = Field of View --> https://www.10xgenomics.com/support/software/xenium-onboard-analysis/latest/analysis/xoa-output-understanding-outputs

xenium.obj = LoadXenium(XeniumRanger_outs, fov = "fov")
print(ncol(xenium.obj))
xenium.obj = subset(xenium.obj, subset = nCount_Xenium > 0)
print(ncol(xenium.obj))

VlnPlot(xenium.obj, features = c("nFeature_Xenium", "nCount_Xenium"), ncol = 2, pt.size = 0)
ggsave(paste(sampleID,"-Seurat_import_nCount_gt_0-Feature_Violin.png",sep=""))

ImageDimPlot(xenium.obj, fov = "fov", molecules = c("CDH16", "CENPF", "EGFR", "MKI67"), nmols = 20000)
ggsave(paste(sampleID,"-Seurat_import_nCount_gt_0-ImagePlot_QC.png",sep=""))