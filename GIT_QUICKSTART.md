# Git quickstart

From inside the `qd-inventory/` folder.

## First time — create and push

**Option A — GitHub CLI (`gh`):**
```bash
git init
git add .
git commit -m "Initial QD electronics inventory + flags roadmap"
gh repo create qd-inventory --public --source=. --push
```

**Option B — web:** create an empty repo named `qd-inventory` on github.com
(no README/license — keep it empty), then:
```bash
git init
git add .
git commit -m "Initial QD electronics inventory + flags roadmap"
git branch -M main
git remote add origin https://github.com/<your-username>/qd-inventory.git
git push -u origin main
```

## Every update after that
```bash
python scripts/export_mirrors.py
git add -A
git commit -m "Inventory: <what changed>"
git push
```

Each commit is a recoverable snapshot. The thing that bit us before — work vanishing —
is exactly what this prevents.
