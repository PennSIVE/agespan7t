setwd("/out")
img = neurobase::readnii("/in.nii.gz")
RNifti::orientation(img) = "RAS"
img = oro.nifti::nii2oro(img)
mask = neurobase::readnii("/mask.nii.gz")

binmask = mask > min(mask)
neurobase::writenii(binmask, paste0(Sys.getenv("LABEL"), "_binmask"))
img = img * binmask
neurobase::writenii(img, paste0(Sys.getenv("LABEL"), "_ss"))

# img = extrantsr::bias_correct(file = img, correction = "N4")
# neurobase::writenii(img, paste0(Sys.getenv("LABEL"), "_n4"))

ind = WhiteStripe::whitestripe(img, Sys.getenv("WS_TYPE"))
ws = WhiteStripe::whitestripe_norm(img, ind$whitestripe.ind)
neurobase::writenii(ws, paste0(Sys.getenv("LABEL"), "_ws"))

