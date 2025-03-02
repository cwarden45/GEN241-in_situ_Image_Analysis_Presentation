import spatialdata as sd
from spatialdata_io import xenium
#import matplotlib.pyplot as plt
#import seaborn as sns
import scanpy as sc
import squidpy as sq

import sys

SampleID = "Xenium_Prime_Human_Skin_FFPE"
basename10x = "cell_feature_matrix"
#basename10x = "analysis"
#basename10x = "cells"
#basename10x = "transcripts"

#follow example from https://squidpy.readthedocs.io/en/stable/notebooks/tutorials/tutorial_xenium.html
zarr_path = "../"+SampleID+"_xe_outs/"+basename10x+".zarr.zip"
sdata = sd.read_zarr(zarr_path)
#print(sdata)

adata = sdata.tables["table"]
sys.exit() #not recognized for this partiular .zarr file
print(adata)

#use this example to export .h5ad (which I have previously successfully imported into R)? - https://anndata.readthedocs.io/en/latest/generated/anndata.AnnData.write.html
output_h5ad = SampleID + "_" + basename10x + ".h5ad"
adata.write(output_h5ad)

#use this example to export .csv? - https://github.com/scverse/anndata/issues/269
output_csv = SampleID + "_" + basename10x + ".csv"
adata.obs.to_csv(output_csv)

#I believe this shares some similarity to import used for SpatialData: https://spatialdata.scverse.org/en/latest/tutorials/notebooks/notebooks/examples/technology_xenium.html