import flywheel

targets = ['7TAS-003', '7TAS-004', '7TAS-007', '7TAS-010', '7TAS-011', '7TAS-013', '7TAS-017', '7TAS-018', '7TAS-024']
files = []
fw = flywheel.Client()
project = fw.lookup('cnet/7T-MS-agespan')
subjects = project.subjects()
for sub in subjects:
    if sub.label in targets:
        for ses in sub.sessions():
            if 'lesion-mask' in ses.label.lower():
                print("Downloading", sub.label, ses.label)
                full_ses = fw.get(ses.id)
                files.append(full_ses)

fw.download_tar(files, '../data/manual_segs.tar')
# extract with tar -xvf manual_segs.tar
# mv 'scitran/cnet/7T-MS-agespan/7TAS-010/Lesion-Mask-and-MP2RAGE/for-mimosa/S10-7Tbaseline-reorient-lesions-mks (2).nii.gz' scitran/cnet/7T-MS-agespan/7TAS-010/Lesion-Mask-and-MP2RAGE/for-mimosa/S10-7Tbaseline-reorient-lesions-mks.nii.gz
# mv 'scitran/cnet/7T-MS-agespan/7TAS-017/Lesion-Mask-and-MP2RAGE/for-mimosa/S017-7Tbaseline-reorient-lesion-mask-AM-mks (2).nii.gz' scitran/cnet/7T-MS-agespan/7TAS-017/Lesion-Mask-and-MP2RAGE/for-mimosa/S017-7Tbaseline-reorient-lesion-mask-AM-mks.nii.gz

