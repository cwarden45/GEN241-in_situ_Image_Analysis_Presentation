Slides used for presentation are available [here]().

*10x Xenium* data for **Lung Cancer FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard).

*10x Xenium* data for **Melanoma FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-skin).
 - This download contains fewer total files.  For example, the lung cancer dataset has *cell_feature_matrix.h5*+*cell_feature_matrix.tar.gz*+*cell_feature_matrix.zarr.zip* files, while this dataset **only** has a *cell_feature_matrix.zarr.zip* file.

**NOTE**: In order to update `anndata` and be able to import `zarr` data with `read_zarr()`, I re-installed using `devtools::install_github("dynverse/anndata")` and I then installed/updated *all* dependencies.

## *Giotto* Pre-Processing / QC

Code executed using `Giotto.R`

**NOTE**: I installed *Giotto Suite* using `devtools::install_github("drieslab/Giotto")`.

**NOTE**: As described [here](https://giottosuite.readthedocs.io/en/latest/subsections/datasets/xenium_breast_cancer.html), I needed to **de-compress** the content of the `cell_feature_matrix.tar.gz` file.

## *Seurat* Pre-Processing / QC

Code executed using `Seurat.R`

**NOTE**: I had some difficulty with Seurat recognizing the downloaded files using `LoadXenium(), and I specifically needed to **de-compress** the content of the `cell_feature_matrix.tar.gz` file (following the *Giotto* instructions).

## *SingleR* Cell Type Assignments

Additional testing/application of *SingleR* to *Xenium* data can be found in [Cheng_et_al_2025](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-025-06044-0).
