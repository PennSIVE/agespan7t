mask = neurobase::readnii(Sys.getenv("MASK"))
mask[mask!=0] = 1
RNifti::orientation(mask) = "RAS"
mask = oro.nifti::nii2oro(mask)
neurobase::writenii(mask, Sys.getenv("OUT"))

