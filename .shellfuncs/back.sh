function back {
	if [[ $1 =~ ^[1-9][0-9]*$ ]]; then
		path=`yes ".." | head -n $1 | tr '\n' '/'`
		cd $path
	fi
}
