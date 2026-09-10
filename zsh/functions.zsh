# ============ FUNCTIONS ============
bikes() {
  local env_path="$HOME/Documents/mini_projects/santander-env/bin/activate"
  local script_path="$HOME/Documents/mini_projects/santander_cli.py"
  # Postcode is deliberately not hardcoded: this repo is public, and a fixed
  # postcode would publish a home location. Set it per machine in an
  # untracked file, e.g. ~/.zshenv:  export BIKES_POSTCODE="AB1 2CD"
  local postcode="${BIKES_POSTCODE:-}"

  if [ -z "$postcode" ]; then
    echo "bikes: set BIKES_POSTCODE in ~/.zshenv (e.g. export BIKES_POSTCODE=\"AB1 2CD\")" >&2
    return 1
  fi

  if [ ! -f "$env_path" ] || [ ! -f "$script_path" ]; then
    echo "bikes: local Santander script not available on this machine"
    return 1
  fi

  source "$env_path"
  python3 "$script_path" --postcode "$postcode" --radius "${1:-700}"
  deactivate
}

reposcheck() {
  cd ~/repos || return
  for d in */.git; do
    repo=${d%/.git}
    echo "---- $repo ----"
    (cd "$repo" && git status -sb)
  done
}

repospushall() {
  cd ~/repos || return
  for d in */.git; do
    repo=${d%/.git}
    cd "$repo" || continue

    if [[ -n $(git status --porcelain) ]]; then
      echo "---- $repo ----"
      git add .
      git commit -m "update"
      git push
    fi

    cd ..
  done
}

python_venv() {
  local MYVENV=".venv"
  if [[ -d "$MYVENV" && -f "$MYVENV/bin/activate" ]]; then
    if [[ -z "${VIRTUAL_ENV:-}" || "$VIRTUAL_ENV" != "$(pwd)/$MYVENV" ]]; then
      source "$MYVENV/bin/activate" > /dev/null 2>&1
    fi
  else
    if [[ -n "${VIRTUAL_ENV:-}" ]] && type deactivate >/dev/null 2>&1; then
      deactivate > /dev/null 2>&1
    fi
  fi
}

newcpp() {
  cp -R ~/repos/templates/cpp-template ~/repos/projects/cpp/$1
  cd ~/repos/projects/cpp/$1
  cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  cmake --build build
  nvim .
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv
python_venv
