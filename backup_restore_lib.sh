#!bin/bash

function validate_backup(){
src_path=$1
dest_path=$2
encr_key=$3
if [ $# == 0 ]; then 
echo " Cannot proceed. No parameters given"
exit 1
fi
if [ $# -ne 3 ]; then
echo " Cannot proceed. No.of parameters given should be 3."
exit 1
fi 

if [ -d $src_path ] || [ -d $dest_path ]; then 
if [ $src_path == $dest_path ]; then
echo " Invalid.Source file path and destination file path cannot be the same."
exit 1 
else
echo " Source file and destination file path valid."
fi
else
echo " Invalid. No such directories exist."
exit 1
fi 
}


function validate_restore(){
src_path=$1
dest_path=$2
decr_key=$3
if [ $# == 0 ]; then 
echo " Cannot proceed. No parameters given"
exit 1
fi
if [ $# -ne 3 ]; then
echo " Cannot proceed. No.of parameters given should be 3."
exit 1
fi 

if [ -d $src_path ] || [ -d $dest_path ]; then 
if [ $src_path == $dest_path ]; then
echo " Invalid.Source file path and destination file path cannot be the same."
exit 1 
else
echo " Source file and destination file path valid."
fi
else
echo " Invalid. No such directories exist."
exit 1
fi 
}

function backup(){
src_path=$1
dest_path=$2
encr_key=$3
current_date=$(date | sed 's/[ : ]/_/g')
backup_dir="$dest_path/$current_date"
mkdir -p "$backup_dir"

for directory in "$src_path"/*/; do 
if [ -d "$directory" ]; then
org_dir_name=$(basename "$directory")
backup_filename="$backup_dir/${org_dir_name}_$current_date.tar.gz"

tar -czf "$backup_filename" -C "$src_path" "$org_dir_name"
gpg --batch --yes --passphrase "$encr_key" -c "$backup_filename"

if [ -f "$backup_filename.gpg" ]; then
echo "directory backup and encryption successful."
rm -f "$backup_filename"
else
echo " directory backup and encryption failed."
exit 1
fi
fi 
done

files_archive="$backup_dir/files_backup_$current_date.tar"
for file in "$src_path"/*; do
if [ -f "$file" ]; then
org_f_name=$(basename "$file")
if [ -!f "$files_archive" ]; then
tar -cf "$files_archive" -C "$src_path" "$org_f_name"
else 
tar -uf "$files_archive" -C "$src_path" "$org_f_name"
fi 
fi 
done

gzip "$files_archive"
gpg --batch --yes --passphrase "$encr_key" -c "$files_archive.gz"

if [ -f "$files_archive.gz.gpg" ]; then
echo "files backup and encryption successful."
rm -f "$files_archive.gz"
else
echo "files backup and encryption failed."
exit 1
fi

}


function restore(){
dest_path=$1
src_path=$2
decr_key=$3
current_date=$(date | sed 's/[ : ]/_/g')
temp_dir="$src_path/$current_date"
mkdir -p "$temp_dir"

for file in "$dest_path"/*.gpg; do 
if [ -f "$file" ]; then
org_f_name=$(basename "$file".gpg)
restore_filename="$temp_dir/$org_f_name"
gpg --batch --yes --passphrase "$decr_key" -o "$restore_filename" -d "$file"
fi 
done
for restore_filename in "$temp_dir"/*; do
tar -xzf "$restore_filename" -C "$src_path"
done
rm -rf "$temp_dir"
echo "restore and decryption successful"

}
