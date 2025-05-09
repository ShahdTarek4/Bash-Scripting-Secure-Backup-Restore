
# 🔐 Bash-Scripting-Secure-Backup-Restore

A secure file backup and restoration system built with Bash scripts that provides encrypted backups and simple recovery operations.

---

## 📋 Overview

This project implements a secure backup and restore solution using Bash scripting. It backs up directories and files separately, compresses them with `tar`, and encrypts them using **GPG** for security. The system preserves directory structure while ensuring data confidentiality.

---

## ✨ Features

- **Secure Encryption**: Uses GPG for symmetric encryption of all backup files  
- **Separate Handling**: Processes directories and files independently for organized structure  
- **Compression**: Leverages `tar` and `gzip` to reduce backup size  
- **Validation**: Performs robust parameter validation to avoid user errors  
- **Modular Design**: Code is modularized with a separate library file  
- **Timestamped Backups**: Automatically adds date-based folders for backups  
- **Automated Scheduling**: Easily integrated with `cron` for periodic backups  

---

## 🔧 Requirements

- Linux/Unix environment  
- Bash shell  
- GNU Privacy Guard (GPG) installed  
- `tar` utility  

---

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ShahdTarek4/Bash-Scripting-Secure-Backup-Restore.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd Bash-Scripting-Secure-Backup-Restore
   ```

3. **Make the scripts executable:**
   ```bash
   chmod +x backup.sh restore.sh
   ```

---

## 📖 Usage

### 🔄 Backup Script

You can run the backup script in two ways:

#### 🔹 Interactive Mode
```bash
bash backup.sh
```
You will be prompted to enter:
1. Source directory path (directory to backup)  
2. Destination directory path (where to store the backup)  
3. Encryption key (password to secure your backup)

#### 🔹 Command-Line Arguments
```bash
bash backup.sh <source_directory> <destination_directory> <encryption_key>
```

---

### ♻️ Restore Script

You can run the restore script in two ways:

#### 🔹 Interactive Mode
```bash
bash restore.sh
```
You will be prompted to enter:
1. Backup directory path (where the encrypted backup is stored)  
2. Restore directory path (where to restore the files)  
3. Decryption key (password used during backup)

#### 🔹 Command-Line Arguments
```bash
bash restore.sh <backup_directory> <restore_directory> <decryption_key>
```

---

## ⚙️ How It Works

### ✅ Backup Process

1. Validates all input parameters  
2. Creates a timestamped directory for the current backup  
3. For each directory in the source:  
   - Creates a compressed tar archive  
   - Encrypts the archive with the provided key  
   - Removes the unencrypted archive  

4. For all files in the source:  
   - Groups them into a single compressed tar archive  
   - Encrypts the archive with the provided key  
   - Removes the unencrypted archive  

### ✅ Restore Process

1. Validates all input parameters  
2. Creates a temporary directory for processing  
3. Decrypts all encrypted files using the provided key  
4. Extracts all archives to the destination directory  
5. Cleans up temporary files  

---

## 🕒 Automated Backups

To schedule automatic backups using cron:

1. Open your crontab file:
   ```bash
   crontab -e
   ```

2. Add a line to run the backup script hourly (adjust paths as needed):
   ```bash
   0 * * * * /path/to/backup.sh /path/to/source /path/to/destination encryption_key
   ```

3. Save and exit

