#setwd("D:\\10x_Xenium_Data\\GEN241-in_situ_Image_Analysis_Presentation")

sampleID="LungCancer_FFPE"
xenium_folder = "../Xenium_V1_humanLung_Cancer_FFPE_outs"
results_folder = ""

library(Giotto)

#follow example from https://giottosuite.readthedocs.io/en/latest/subsections/datasets/xenium_breast_cancer.html
instrs = createGiottoInstructions(save_dir = results_folder,
                                  save_plot = TRUE,
                                  show_plot = FALSE,
                                  return_plot = FALSE)
								  
settings_path = paste(xenium_folder,"/experiment.xenium",sep="")
cell_bound_path = paste(xenium_folder,"/cell_boundaries.csv.gz",sep="")
nuc_bound_path = paste(xenium_folder,"/nucleus_boundaries.csv.gz",sep="")
tx_path = paste(xenium_folder,"/transcripts.csv.gz",sep="")
feat_meta_path = paste(xenium_folder,"/cell_feature_matrix/features.tsv.gz",sep="")
expr_mat_path = paste(xenium_folder,"/cell_feature_matrix",sep="")
cell_meta_path = paste(xenium_folder,"/cells.csv.gz",sep="")

feature_dt = data.table::fread(feat_meta_path, header = FALSE)
colnames(feature_dt) = c('ensembl_ID','feat_name','feat_type')
feature_dt[, table(feat_type)]
feat_types = names(feature_dt[, table(feat_type)])
feat_types_IDs = lapply(
  feat_types, function(type) feature_dt[feat_type == type, unique(feat_name)]
)
names(feat_types_IDs) = feat_types

tx_dt = data.table::fread(tx_path)
data.table::setnames(x = tx_dt,
                     old = c('feature_name', 'x_location', 'y_location'),
                     new = c('feat_ID', 'x', 'y'))
print(nrow(tx_dt))
tx_dt_filtered = tx_dt[qv >= 20]
print(nrow(tx_dt_filtered))
tx_dt_types = lapply(
  feat_types_IDs, function(types) tx_dt_filtered[feat_ID %in% types]
)
invisible(lapply(seq_along(tx_dt_types), function(x) {
  cat(names(tx_dt_types)[[x]], 'detections: ', tx_dt_types[[x]][,.N], '\n')
}))

gpoints_list = lapply(
  tx_dt_types, function(x) createGiottoPoints(x = x)
) # 208.499 sec elapsed

png(paste(sampleID,"-Giotto_import_QV_gt_20-ImagePlot_NegativeControls.png",sep=""),
	width=1500, height=500)
par(mfcol=c(1,3))
############################################################################
### I believe this is around the point where I recieved an error message ###
############################################################################
plot(gpoints_list$`Blank Codeword`,
     point_size = 0.3,
     main = 'Blank Codeword')
plot(gpoints_list$`Negative Control Codeword`,
     point_size = 0.3,
     main = 'Negative Control Codeword')
plot(gpoints_list$`Negative Control Probe`,
     point_size = 0.3,
     main = 'Negative Control Probe')
dev.off()

png(paste(sampleID,"-Giotto_import_QV_gt_20-ImagePlot_SelectedGenes4.png",sep=""))
plot(gpoints_list$`Gene Expression`,  # 77.843 sec elapsed
     feats = c("CDH16", "CENPF", "EGFR", "MKI67"))
tx_dt_types$`Gene Expression`[feat_ID %in% c("CDH16", "CENPF", "EGFR", "MKI67"), table(feat_ID)]
dev.off()