#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="Melanoma_FFPE"
XeniumRanger_outs = "../Xenium_Prime_Human_Skin_FFPE_xe_outs"

library(anndata)
library(Seurat)
library(ggplot2)

zarr.analysis = paste(XeniumRanger_outs,"analysis.zarr",sep="/")
zarr.cell_feature_matrix = paste(XeniumRanger_outs,"cell_feature_matrix.zarr",sep="/")
zarr.cells = paste(XeniumRanger_outs,"cells.zarr",sep="/")
zarr.transcripts = paste(XeniumRanger_outs,"transcripts.zarr",sep="/")

## ERROR MESSAGE Commands
#anndata.analysis =  read_zarr(zarr.analysis)
#anndata.cell_feature_matrix =  read_zarr(zarr.cell_feature_matrix)
#anndata.cells =  read_zarr(zarr.cells)
anndata.transcripts =  read_zarr(zarr.transcripts)

#if I could create matrices from the .zarr files, then I could try to create a Seurat object : https://satijalab.org/seurat/articles/pbmc3k_tutorial.html 
