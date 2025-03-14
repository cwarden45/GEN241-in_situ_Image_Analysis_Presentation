**Slides used for presentation are available [here](https://drive.google.com/file/d/1P6-2KYSn5zstn1F_6lHSyHeTjJZ1Kx8d/view?usp=sharing)**.  There is also an [earlier "v2" version](https://drive.google.com/file/d/1T1yQjhTHX_aVShp4HDq8AGQXbRbA1hI5/view?usp=sharing) of the slides that was passed along to some selected individuals.

*10x Xenium* data for **Lung Cancer FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard).

*10x Xenium* data for **Melanoma FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-skin).
 - This download contains fewer total files.  For example, the lung cancer dataset has *cell_feature_matrix.h5*+*cell_feature_matrix.tar.gz*+*cell_feature_matrix.zarr.zip* files, while this dataset **only** has a ***cell_feature_matrix.zarr.zip*** file.

**NOTE**: In order to update `anndata` and be able to import `zarr` data with `read_zarr()`, I re-installed using `devtools::install_github("dynverse/anndata")` and I then installed/updated *all* dependencies.

**NOTE**: I am very thankful that **10x Support** indicated that their [current recommendation](https://www.10xgenomics.com/support/software/xenium-onboard-analysis/latest/advanced/example-code#zarr) to reading the *.zarr* files (using *Python* to convert to a different file format that can be imported into *R*).
 - I performed some amount of testing with the example code in `python-zarr.py`.  However, I believe that I need some additional steps to export something that can be imported into R.
 - I also started to test *squidpy* / *SpatialData* functions from [this tutorial](https://squidpy.readthedocs.io/en/stable/notebooks/tutorials/tutorial_xenium.html) in `squidpy-zarr.py`.  However, I encountered some an messages when I tried to use the .zarr files that were available for the Melanoma FFPE sample (versus demo data for those packages, for example).
 - If it might help, then there are instructions for working with data interactively with *Napari-SpatialData* [here](https://spatialdata.scverse.org/projects/napari/en/latest/notebooks/spatialdata.html).

## *Giotto* Pre-Processing / QC

Code executed using `Giotto.R`

**NOTE**: I installed *Giotto Suite* using `devtools::install_github("drieslab/Giotto")`.

**NOTE**: As described [here](https://giottosuite.readthedocs.io/en/latest/subsections/datasets/xenium_breast_cancer.html), I needed to **de-compress** the content of the `cell_feature_matrix.tar.gz` file.

<table>
<tbody>
    <tr>
      <th align="center"></th>
      <th align="center">Initial Import</th>
      <th align="center">QV > 20</th>
      <th align="center">Feature Count > 0</th>
    </tr>
    <tr>
	<td align="left">Total Feature Observations</td>
	<td align="center">12,165,021</td>
	<td align="center">10,607,572</td>
	<td align="center">?</td>
    </tr>
	<tr>
	<td align="left">Cell Count</td>
	<td align="center">?</td>
	<td align="center">?</td>
	<td align="center">?</td>
    </tr>
</tbody>
</table>

**NOTE**: There was a point where the script almost crashed my personal computer (with 16 GB of RAM and 4 CPU).  This was with the *smaller 10x Visium* sample.

So, I uploaded the attempted code, and this gave me additional ideas for other analysis.  However, I did not continue to troubleshoot this particular code.

## *Seurat* Pre-Processing / QC

**NOTE**: I had some difficulty with Seurat recognizing the downloaded files using `LoadXenium()`, and I specifically needed to **de-compress** the content of the `cell_feature_matrix.tar.gz` file (following the *Giotto* instructions).

**NOTE**: Based upon the [*Giotto Suite* example](https://giottosuite.readthedocs.io/en/latest/subsections/datasets/xenium_breast_cancer.html), I also added some code to define **negative control** metrics.  However, there were **not** among the features defined with `LoadXenium()`, which makes all of the values equal to 0.

**Lung Cancer FFPE**:

Code executed using `Seurat.R`

<table>
  <tbody>
    <tr>
      <th align="center"></th>
      <th align="center">Initial Import</th>
      <th align="center">Feature Count > 0</th>
      <th align="center">Feature Count > 20</th>
      <th align="center">Feature Count > 40</th>
    </tr>
    <tr>
	<td align="left">Cell Count</td>
	<td align="center">162,254</td>
	<td align="center">161,894</td>
	<td align="center">135,782</td>
	<td align="center"> 91,459</td>
    </tr>
</tbody>
</table>

**NOTE**: *Feature Count > 20* (and *Feature Count > 40* ) are not defined until after running `SingleR-from_Seurat.R` (with *min_counts = 20* or *min_counts = 40*).

<img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-Seurat_import_nCount_gt_0-Feature_Violin.png" width="500" height="500">

<img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-Seurat_import_nCount_gt_0-ImagePlot_QC.png" width="500" height="500">

**Melanoma FFPE**:

Attempted to execute code within `Seurat-zarr.R`


## *SingleR* Cell Type Assignments

**Lung Cancer FFPE**:

Code executed using `SingleR-from_Seurat.R`

*Keep MinCounts > 0, Apply Seurat Normalization*:

<table>
<tbody>
    <tr>
      <th align="center">HPCA</th>
      <th align="center">Blueprint/ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount0-SeuratNorm--Seurat_import-SingleR_HPCA-ImagePlot.png" width="350" height="350">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount0-SeuratNorm--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png" width="350" height="350">
</td>
</tbody>
</table>

*Keep MinCounts > 0, **No** Seurat Normalization*:

<table>
<tbody>
    <tr>
      <th align="center">HPCA</th>
      <th align="center">Blueprint/ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount0-NoNorm--Seurat_import-SingleR_HPCA-ImagePlot.png" width="350" height="350">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount0-NoNorm--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png" width="350" height="350">
</td>
</tbody>
</table>

*Apply **MinCounts > 20**, **No** Seurat Normalization*:

<table>
<tbody>
    <tr>
      <th align="center">HPCA</th>
      <th align="center">Blueprint/ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount20-NoNorm--Seurat_import-SingleR_HPCA-ImagePlot.png" width="350" height="350">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount20-NoNorm--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png" width="350" height="350">
</td>
</tbody>
</table>

*Apply **MinCounts > 40**, **No** Seurat Normalization*:

<table>
<tbody>
    <tr>
      <th align="center">HPCA</th>
      <th align="center">Blueprint/ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount40-NoNorm--Seurat_import-SingleR_HPCA-ImagePlot.png" width="350" height="350">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount40-NoNorm--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png" width="350" height="350">
</td>
</tbody>
</table>

*Apply **MinCounts > 80**, **No** Seurat Normalization*:

<table>
<tbody>
    <tr>
      <th align="center">HPCA</th>
      <th align="center">Blueprint/ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount80-NoNorm--Seurat_import-SingleR_HPCA-ImagePlot.png" width="350" height="350">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount80-NoNorm--Seurat_import-SingleR_blueprint_ENCODE-ImagePlot.png" width="350" height="350">
</td>
</tbody>
</table>

**Other**:

Additional testing/application of *SingleR* to *Xenium* data can be found in [Cheng_et_al_2025](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-025-06044-0).

## General *Seurat* Cell Clustering

Code executed using `Seurat-Normalization_and_Clustering.R`

<table>
  <tbody>
    <tr>
      <th align="center">Feature Count > 0</th>
      <th align="center">Feature Count > 20</th>
      <th align="center">Feature Count > 40</th>
      <th align="center">Feature Count > 80</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount0-SeuratNorm-ImagePlot_SeuratClusters.png" width="250" height="250"></td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount20-SeuratNorm-ImagePlot_SeuratClusters.png" width="250" height="250"></td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount40-SeuratNorm-ImagePlot_SeuratClusters.png" width="250" height="250"></td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/LungCancer_FFPE-mincount80-SeuratNorm-ImagePlot_SeuratClusters.png" width="250" height="250"></td>
    </tr>
</tbody>
</table>

[Hartman and Satija 2024](https://elifesciences.org/reviewed-preprints/96949) describe running [*Baysor*](https://kharchenkolab.github.io/Baysor/dev/) with `--min-molecules-per-cell=100`.  For those that are interested, *10x* also provides some information about running *Baysor* on *Xenium* data [here](https://www.10xgenomics.com/analysis-guides/using-baysor-to-perform-xenium-cell-segmentation).  *Either way, it is possible that some samples may benefit from a higher threshold of minimum counts per cell (such as **100 or higher**).*

## Post-Presentation Notes

After the presentation, some details of the [*Visium HD*](https://www.10xgenomics.com/products/visium-hd-spatial-gene-expression) technology ([Oliveira et al. 2024](https://www.biorxiv.org/content/10.1101/2024.06.04.597233v1)) were brought to my attention.  I am very thankful for this discussion, and labs planning spatial transcriptomic projects should at least be aware of this option.

You can see some *YouTube* videos related to analysis/re-analysis [here](https://www.youtube.com/watch?v=q3w2UElzv6M) and [here](https://www.youtube.com/watch?v=zKZ03mA3aig).  *Bin2cell* ([Polański et al. 2024](https://academic.oup.com/bioinformatics/article/40/9/btae546/7754061)) is also an example of an analysis method available for this platform.
