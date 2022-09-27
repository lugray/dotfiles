#!/usr/bin/env zsh

dev_clone() {
  local org_dir
  org_dir="${HOME}/src/github.com/$(echo $1 | cut -d/ -f1)"
  repo_dir="${HOME}/src/github.com/$1"
  mkdir -p "${org_dir}"
  if [ ! -d "${repo_dir}" ]; then
    git clone "https://github.com/$1" "${repo_dir}"
  fi
}

dev_clone zsh-users/zsh-autosuggestions
dev_clone zsh-users/zsh-syntax-highlighting
dev_clone so-fancy/diff-so-fancy

source_dir="${0:a:h}"
if [[ ${source_dir} != ${HOME} ]]; then # Support repo not in ~ for spin
  for file in `git -C "${source_dir}" ls-files`; do
    if [[ "${file}" = "${0:t}" ]]; then
      continue
    fi
    source_path="${source_dir}/${file}"
    dest_path="${HOME}/${file}"
    mkdir -p "$(dirname "${dest_path}")"
    cp "${source_path}" "${dest_path}"
  done
fi

if [ -f /etc/spin/secrets/copilot_hosts.json ]; then
  mkdir -p "${HOME}/.config/github-copilot"
  cp /etc/spin/secrets/copilot_hosts.json "${HOME}/.config/github-copilot/hosts.json"
fi

bat cache --build
~/.config/nvim/update
