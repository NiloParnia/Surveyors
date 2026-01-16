#!/usr/bin/env python3
from __future__ import annotations

import subprocess
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
OUT_PATH = REPO_ROOT / "docs" / "CHATGPT_SNAPSHOT.md"

PRIORITY_FILES = [
  "default.project.json",
  "README.md",
  "docs/MIRA_CONTEXT.md",
  "docs/00-START-HERE.md",
  "docs/01-ARCHITECTURE.md",
  "docs/02-ROADMAP-90D.md",
  "docs/03-NEXT-STEPS.md",
  "docs/04-TROUBLESHOOTING.md",
  "src/shared/Net/RemoteDefs.luau",
  "src/shared/Net/Net.luau",
  "src/server/RemotesSetup.luau",
  "src/server/ServerBoot.luau",
  "src/server/ServicesLoader.luau",
  "src/server/init.server.luau",
  "src/client/ClientBoot.luau",
  "src/client/ControllersLoader.luau",
  "src/client/init.client.luau",
  "src/shared/Config/GameConfig.lua",
  "src/shared/Util/Util.lua",
]

MAX_CHARS = 40000  # safety cap per file; repo is small so this is generous

def git(*args: str) -> str:
  return subprocess.check_output(["git", *args], cwd=REPO_ROOT, text=True, encoding="utf-8", errors="replace").strip()

def safe_read(path: Path) -> str:
  data = path.read_text(encoding="utf-8", errors="replace")
  if len(data) <= MAX_CHARS:
    return data
  head = data[:20000]
  tail = data[-20000:]
  return head + "\\n\\n... [TRUNCATED] ...\\n\\n" + tail

def main() -> int:
  OUT_PATH.parent.mkdir(parents=True, exist_ok=True)

  now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
  branch = git("rev-parse", "--abbrev-ref", "HEAD")
  head = git("rev-parse", "HEAD")
  last = git("log", "-1", "--pretty=%h %s")

  try:
    changed = git("diff", "--name-only", "HEAD~1..HEAD")
  except Exception:
    changed = ""

  tracked = git("ls-files")

  out = []
  out.append("# Surveyors ChatGPT Snapshot")
  out.append("")
  out.append(f"Generated: {now}")
  out.append(f"Branch: {branch}")
  out.append(f"HEAD: {head}")
  out.append(f"Last commit: {last}")
  out.append("")

  out.append("## Changed files (last commit)")
  out.append("```")
  out.append(changed if changed else "(none or first commit)")
  out.append("```")
  out.append("")

  out.append("## Git tracked files")
  out.append("```")
  out.append(tracked)
  out.append("```")

  for rel in PRIORITY_FILES:
    p = REPO_ROOT / rel
    out.append("")
    out.append(f"## {rel}")
    if p.exists():
      out.append("```")
      out.append(safe_read(p))
      out.append("```")
    else:
      out.append("_(missing)_")

  OUT_PATH.write_text("\\n".join(out) + "\\n", encoding="utf-8")
  print(f"Wrote {OUT_PATH}")
  return 0

if __name__ == "__main__":
  raise SystemExit(main())

