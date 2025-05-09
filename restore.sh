#!bin/bash
source ./backup_restore_lib.sh

read -p "enter backup directory path " dest_path
read -p "enter restore directory path " src_path
read -p " enter decryption key " decr_key

#validate_restore $src_path $dest_path $decr_key
restore $dest_path $src_path $decr_key
