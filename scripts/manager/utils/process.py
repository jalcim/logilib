import re
import subprocess
from gi.repository import GLib

_PROGRESS_RE = re.compile(r'\[\s*(\d+)\s*/\s*(\d+)\s*\]')

def run_with_progress(cmd: list, parse_progress: bool,
                      loading, log_cb):
    """
    Exécute cmd, envoie chaque ligne à log_cb, met à jour loading.update().
    """
    proc = subprocess.Popen(cmd,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT,
                            text=True)
    loading.processes.append(proc)
    for line in proc.stdout:
        GLib.idle_add(log_cb, line)
        if parse_progress and not loading.stop_event.is_set():
            m = _PROGRESS_RE.search(line)
            if m:
                cur, tot = map(int, m.groups())
                frac = cur/tot if tot else 0
                GLib.idle_add(loading.update, frac, f"{cur}/{tot}")
        if loading.stop_event.is_set():
            proc.kill()
            break
    proc.wait()
    if proc.returncode != 0:
        raise subprocess.CalledProcessError(proc.returncode, cmd)
