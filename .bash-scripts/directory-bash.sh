check_bash () {
  if stat --printf='' ./.bash-dirr 2>/dev/null
  then
    . ./.bash-dirr
  fi
}
