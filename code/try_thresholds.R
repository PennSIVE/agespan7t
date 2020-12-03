library(fslr)

suffix = Sys.getenv("SUFFIX")
subjs = c('7TAS-003', '7TAS-004', '7TAS-007', '7TAS-010', '7TAS-011', '7TAS-013', '7TAS-017', '7TAS-018', '7TAS-024')
thresholds = c(0.05, 0.1, 0.2, 0.3, 0.4)
results = data.frame(matrix(ncol = 5, nrow = 9))
colnames(results) = thresholds
i = 1
for (subj in subjs) {
  print(subj)
  probmap = readnii(paste0('../data/scitran/cnet/7T-MS-agespan/', subj, '/probability_map', suffix,'.nii.gz'))
  gs = readnii(list.files(path = paste0('../data/scitran/cnet/7T-MS-agespan/', subj), pattern = "mks-bin.nii.gz", recursive = TRUE, full.names = TRUE)[1])
  for (thresh in thresholds) {
    binmap = probmap > thresh
    dir.create(paste0('../data/scitran/cnet/7T-MS-agespan/', subj, '/thresholds', suffix), showWarnings = FALSE)
    writenii(binmap, paste0('../data/scitran/cnet/7T-MS-agespan/', subj, '/thresholds', suffix, '/', thresh))
    dice = fsl_dice(gs, binmap)
    print(paste(subj, dice))
    results[, which(colnames(results) == thresh)][i] = dice
  }
  i = i + 1
}
write.table(results, file = paste0("../data/results", suffix,".csv"), sep = ",")
