#!bin/bash
source ./backup_restore_lib.sh

read -p "enter source file path " src_path 
read -p "enter destination file path " dest_path
read -p " enter encryption key " encr_key
validate_backup $src_path $dest_path $encr_key
backup $src_path $dest_path $encr_key
