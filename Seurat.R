#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="LungCancer_FFPE"
XeniumRanger_outs = "../Xenium_V1_humanLung_Cancer_FFPE_outs"

library(Seurat)

#follow example code : https://satijalab.org/seurat/articles/seurat5_spatial_vignette_2#mouse-brain-10x-genomics-xenium-in-situ
#FOV = Field of View --> https://www.10xgenomics.com/support/software/xenium-onboard-analysis/latest/analysis/xoa-output-understanding-outputs

xenium.obj = LoadXenium(XeniumRanger_outs, fov = "fov")