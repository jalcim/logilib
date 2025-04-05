import os

def scan_directories(root: str) -> dict:
    """Renvoie un dict des sous-dossiers de 'root'."""
    tree = {}
    for entry in os.scandir(root):
        if entry.is_dir():
            tree[entry.name] = scan_directories(os.path.join(root, entry.name))
    return tree

def archive_build_dir(build_dir: str="build", prefix: str="build.old") -> None:
    """
    Si 'build_dir' existe, le renomme en build.oldX (X libre).
    """
    if not os.path.isdir(build_dir):
        return
    i = 1
    while os.path.exists(f"{prefix}{i}"):
        i += 1
    os.rename(build_dir, f"{prefix}{i}")

def get_directory_tree(root):
    tree = {}
    for e in os.scandir(root):
        if e.is_dir():
            tree[e.name] = get_directory_tree(os.path.join(root, e.name))
    return tree
