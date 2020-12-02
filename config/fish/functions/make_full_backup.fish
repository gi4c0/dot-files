function make_full_backup -d "Run backup of all system to '/media/alex/Backup/regolith_v1.4_ubuntu_20_04/'"
  sudo rsync -aAXv --delete --exclude="/dev/*" --exclude="/proc/*" \
  --exclude="/sys/*" --exclude="/tmp/*" --exclude="/run/*" --exclude="/mnt/*" \
  --exclude="/home/alex/Videos" --exclude="/media/*" --exclude="swapfile" --exclude="lost+found" \
  / /media/alex/Backup/regolith_v1.4_ubuntu_20_04/
end
