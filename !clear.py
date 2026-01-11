from pathlib import Path
import shutil

SKIP_FILE_NAME = "!clear.py"
SKIP_DIR_PREFIX = "!"
TARGET_DIR_NAME = "dwnldata"


def unique_destination(dest_dir: Path, source_name: str, is_dir: bool) -> Path:
    base = source_name
    suffix = ""
    if not is_dir:
        suffix = Path(source_name).suffix
        base = source_name[: -len(suffix)] if suffix else source_name
    candidate = dest_dir / source_name
    if not candidate.exists():
        return candidate
    n = 2
    while True:
        new_name = f"{base}_{n}{suffix}"
        candidate = dest_dir / new_name
        if not candidate.exists():
            return candidate
        n += 1


def move_items(root: Path, dest_dir: Path) -> None:
    for entry in root.iterdir():
        name = entry.name
        if name == SKIP_FILE_NAME:
            continue
        if entry.is_dir() and name.startswith(SKIP_DIR_PREFIX):
            continue
        if entry.resolve() == dest_dir.resolve():
            continue
        target = unique_destination(dest_dir, name, entry.is_dir())
        shutil.move(str(entry), str(target))


def main() -> None:
    root = Path.cwd()
    dest_dir = root / TARGET_DIR_NAME
    dest_dir.mkdir(parents=True, exist_ok=True)
    move_items(root, dest_dir)


if __name__ == "__main__":
    main()
