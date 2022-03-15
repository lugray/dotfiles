#!/usr/bin/env zsh

devish=/opt/dev/bin/dev
if ! [[ -x "${devish}" ]] && [[ -x /opt/minidev/bin/dev ]]; then
  devish=/opt/minidev/bin/dev
fi

if [[ -x "${devish}" ]]; then
  $devish clone zsh-users/zsh-autosuggestions
  $devish clone zsh-users/zsh-syntax-highlighting
  $devish clone so-fancy/diff-so-fancy
fi


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

bat cache --build
