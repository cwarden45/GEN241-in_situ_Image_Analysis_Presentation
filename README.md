Slides used for presentation are available [here]().

*10x Xenium* data for **Lung Cancer FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard).

*10x Xenium* data for **Melanoma FFPE** sample downloaded from [here](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-skin).
 - This download contains fewer total files.  For example, the lung cancer dataset has *cell_feature_matrix.h5*+*cell_feature_matrix.tar.gz*+*cell_feature_matrix.zarr.zip* files, while this dataset **only** has a ***cell_feature_matrix.zarr.zip*** file.

**NOTE**: In order to update `anndata` and be able to import `zarr` data with `read_zarr()`, I re-installed using `devtools::install_github("dynverse/anndata")` and I then installed/updated *all* dependencies.

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
    </tr>
    <tr>
	<td align="left">Cell Count</td>
	<td align="center">162,254</td>
	<td align="center">161,894</td>
    </tr>
</tbody>
</table>

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
      <th align="center">Blueprint ENCODE</th>
    </tr>
    <tr>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/" width="250" height="150">
</td>
	<td align="center"><img src="https://github.com/cwarden45/GEN241-in_situ_Image_Analysis_Presentation/blob/main/" width="250" height="150">
</td>
</tbody>
</table>

*Keep MinCounts > 0, **No** Seurat Normalization*:

*Apply MinCounts > 20, **No** Seurat Normalization*:


**Other**:

Additional testing/application of *SingleR* to *Xenium* data can be found in [Cheng_et_al_2025](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-025-06044-0).
