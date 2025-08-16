````markdown
# mkv-tv-prep

Batch script to prepare MKV movies for Samsung TVs by embedding English subtitles and converting audio to AC3 for maximum compatibility.

## Requirements

- [FFmpeg](https://ffmpeg.org/) must be installed and available in your PATH.  
  On macOS you can install via:
  ```bash
  brew install ffmpeg
  ```
````

## Folder Structure

Each movie folder should look like this:

```
MovieName/
│── MovieName.ETRG.mkv       # Main movie file (use the one ending with ETRG, not the sample)
│── sample.mkv               # Ignore
│── Subtitles/
    ├── MovieName.English.srt   # English subtitle (this will be embedded)
    ├── MovieName.Spanish.srt
    └── MovieName.French.srt
```

## Usage

1. Place the script (`mkv-tv-prep.sh`) at the root folder where all your movies are stored.
   Example:

   ```
   /Movies/
   │── mkv-tv-prep.sh
   │── Movie1/
   │── Movie2/
   ```

2. Make the script executable:

   ```bash
   chmod +x mkv-tv-prep.sh
   ```

3. Run the script:

   ```bash
   ./mkv-tv-prep.sh
   ```

4. The script will:

   - Find the correct `.mkv` file (ending with `ETRG.mkv`)
   - Embed the English `.srt` subtitle file
   - Convert audio to AC3 (if needed)
   - Save the processed file in the same folder with `_tv.mkv` appended.

## Example

Input:

```
Movie1/Some.Movie.2010.ETRG.mkv
Movie1/Subtitles/Some.Movie.2010.English.srt
```

Output:

```
Movie1/Some.Movie.2010.ETRG_tv.mkv
```

## Notes

- Only English subtitles are embedded (files ending with `English.srt`).
- The original files are untouched.
- Processed files are safe to play directly on Samsung TVs without "Audio not supported" errors.

```

---

👉 Do you want me to also create the actual `mkv-tv-prep.sh` file in a polished version so your repo will have both `README.md` and the script ready to commit?
```
