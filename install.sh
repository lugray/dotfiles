#!/usr/bin/env zsh

. /etc/profile

mkdir -p "${HOME}/src/github.com/zsh-users"
git clone "https://github.com/zsh-users/zsh-autosuggestions" "${HOME}/src/github.com/zsh-users/zsh-autosuggestions"
git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "${HOME}/src/github.com/zsh-users/zsh-syntax-highlighting"

source_dir="${0:a:h}"
for file in `git -C "${source_dir}" ls-files`; do
  if [[ "${file}" = "${0:t}" ]]; then
    continue
  fi
  source_path="${source_dir}/${file}"
  dest_path="${HOME}/${file}"
  mkdir -p "$(dirname "${dest_path}")"
  cp "${source_path}" "${dest_path}"
done

nix-channel --update
nix-shell '<home-manager>' -A install
