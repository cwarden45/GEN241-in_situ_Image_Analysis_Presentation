import zarr
import numpy as np

input_file = "../Xenium_Prime_Human_Skin_FFPE_xe_outs/cell_feature_matrix.zarr.zip"
#input_file = "../Xenium_Prime_Human_Skin_FFPE_xe_outs/analysis.zarr.zip"
#input_file = "../Xenium_Prime_Human_Skin_FFPE_xe_outs/cells.zarr.zip"
#input_file = "../Xenium_Prime_Human_Skin_FFPE_xe_outs/transcripts.zarr.zip"

# DIRECTLY COPY code from 10x : https://www.10xgenomics.com/support/software/xenium-onboard-analysis/latest/advanced/example-code#zarr
def open_zarr(path: str) -> zarr.Group:
    store = (zarr.ZipStore(path, mode="r")
    if path.endswith(".zip")
    else zarr.DirectoryStore(path)
    )
    return zarr.group(store=store)

root = open_zarr(input_file)

print(root.info)
print(root.tree())