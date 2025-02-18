Slides used for presentation are available [here]().

*10x Xenium* data for **Lung Cancer FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard).

*10x Xenium* data for **Melanoma FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-skin).

## *Giotto* Pre-Processing / QC

Code executed using `Giotto.R`

**NOTE**: I installed *Giotto Suite* using `devtools::install_github("drieslab/Giotto")`.
**NOTE**: As described [here](https://giottosuite.readthedocs.io/en/latest/subsections/datasets/xenium_breast_cancer.html), I needed to **de-compress** the content of the `cell_feature_matrix.tar.gz` file.

## *Seurat* Pre-Processing / QC (from *Giotto*)

Code executed using `Seurat.R`

**NOTE**: I had some difficulty with Seurat recognizing the downloaded files using `LoadXenium()`.  So, that is why I tested import with another method that could export data to Seurat.

## *SingleR* Cell Type Assignments (from *Giotto* + "Seurat")

Additional testing/application of *SingleR* to *Xenium* data can be found in [Cheng_et_al_2025](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-025-06044-0).
