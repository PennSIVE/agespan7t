library(fslr)

index = as.numeric(Sys.getenv("INDEX"))
train_dir = "/cbica/projects/agespan7T/repos/agespan7t/data/scitran/cnet/7T-MS-agespan"
subjs = c('7TAS-003', '7TAS-004', '7TAS-007', '7TAS-010', '7TAS-011', '7TAS-013', '7TAS-017', '7TAS-018', '7TAS-024')
t1_files = list.files(path = file.path(train_dir, subjs), pattern = "^UNI_ws.nii.gz$", full.names = TRUE, recursive = TRUE)
flair_files = list.files(path = file.path(train_dir, subjs), pattern = "^T1map_ws.nii.gz$", full.names = TRUE, recursive = TRUE)
tissue_files = list.files(path = file.path(train_dir, subjs), pattern = "^T1map_ss.nii.gz$", full.names = TRUE, recursive = TRUE)
brainmask_files = list.files(path = file.path(train_dir, subjs), pattern = "^UNI_binmask.nii.gz$", full.names = TRUE, recursive = TRUE)
mask_files = list.files(path = file.path(train_dir, subjs), pattern = "mks-bin.nii.gz$", full.names = TRUE, recursive = TRUE)
filepaths = data.frame(t1 = t1_files, flair = flair_files, mask = mask_files, brainmask = brainmask_files, tissue = tissue_files, stringsAsFactors = FALSE)

flair.cur = readnii(filepaths$flair[index])
tissue.cur = readnii(filepaths$tissue[index])
brain_mask = tissue.cur > 0
image_eroded = fslerode(brain_mask, kopts = "-kernel box 5x5x5", retimg = TRUE)
thresh = tissue.cur < 3000
tissue_mask = image_eroded*thresh

writenii(tissue_mask, paste0(train_dir, "/", subjs[index],
                                 "/tissue_mask.nii.gz"))


