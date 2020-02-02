# Powershell_backup 
This script compresses a source path with zip and can backup it to multiple target
paths with timestamps appended to these backed up files

Source and target can be modified using the config.json file, which needs to be placed
in the __same folder__ as the start.ps1

### Known Issues / Flaws
- Only basic configurable
- Paths need to be inserted with escaping in mind ("\\" instead of "\" e.g.)
- A *tmp* folder is created within the root directory of the script which is not cleared after the script is run
  but is when the script is rerun (so only contains one backed up file at most)

### Planned Features
- Backup to Google Drive
- Show Progress while copying files
