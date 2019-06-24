function gcode_time {
  echo "$1: $(date -jur $(head $1 | grep ';TIME:' | sed 's/;TIME://') '+%Hh%Mm%S')"
  if [[ "$#" -gt "1" ]]; then
    shift
    gcode_time $@
  fi
}

function gcode_simple_time {
  date -jur $(head $1 | grep ';TIME:' | sed 's/;TIME://') '+%Hh%Mm%S'
  if [[ "$#" -gt "1" ]]; then
    shift
    gcode_simple_time $@
  fi
}

function gcode_rename_time {
  new_name="$(echo "$1" | sed 's/.gcode//') ($(gcode_simple_time "$1")).gcode"
  echo "'$1' -> '$new_name'" 
  mv "$1" "$new_name"
  if [[ "$#" -gt "1" ]]; then
    shift
    gcode_rename_time $@
  fi
}

function gcode_strip_time {
  rename 's/ \(\d\dh\d\dm\d\d\)//' $@
}
