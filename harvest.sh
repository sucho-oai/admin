#!/bin/bash

while getopts u:a:f: flag
do
	case "${flag}" in
		f) file=${OPTARG};;
		h) harvest=${OPTARG};;
	esac
done

if test -z "$file" 
then
	hosts_file="hosts.txt"
else
	hosts_file=$file
fi
 echo "File: $hosts_file"

if test -z "$harvest" 
then
	do_harvest="yes"
else
	do_harvest=$harvest
fi

 echo "Harvest: $do_harvest"

#Set your Metha extracts directory
oai_dir=~/metha-dir
git_dir=~/sucho-oai/git
asset_dir=~/sucho-oai/assets
b2_folder="b2://sucho-oai"
formats_file="formats.txt"

NOW=$(date +"%Y-%m-%d")
printf "OAI extract date: $NOW" > $output_file
printf '\n' >>$output_file

while IFS="" read -r oai_url || [ -n "$oai_url" ]
do
	printf '%s\n' "$oai_url"
	# convert url to git name format
	line=$(sed s'/http\:\/\///g' <<<"$oai_url")
	line2=$(sed s'/https\:\/\///g' <<<$line)
	git_repo=$(sed s'/\//__/g' <<<$line2)
	echo $git_repo
	#hut git create sucho-$git_repo -v public -d $oai_url
	gh repo create sucho-oai/sucho-$git_repo -d $oai_url --public
	#git clone git@git.sr.ht:~justinkelly/sucho-$git_repo $git_dir/sucho-$git_repo
	git clone git@github.com:sucho-oai/sucho-$git_repo $git_dir/sucho-$git_repo
	git -C $git_dir/sucho-$git_repo pull --no-rebase
	#  rsync repo-readme.md  $git_dir/sucho-$git_repo/README.md
	sed -e "s@OAI_URL@$oai_url@g" -e "s@GIT_REPO@sucho-$git_repo@g" repo-readme.md > $git_dir/sucho-$git_repo/README.md
	#sed "s@GIT_REPO@sucho-$git_repo@g" $git_dir/sucho-$git_repo/README.md > $git_dir/sucho-$git_repo/README.md
	git -C $git_dir/sucho-$git_repo add README.md
	#formats
	curl -s $oai_url?verb=ListMetadataFormats | grep metadataPrefix | cut -f2 -d">" |cut -f1 -d"<" > $git_dir/sucho-$git_repo/oai_formats.txt
	git -C $git_dir/sucho-$git_repo add oai_formats.txt
	if [ -s $git_dir/sucho-$git_repo/oai_formats.txt ]; then
		# The file is not-empty.
		oai_format_file=$git_dir/sucho-$git_repo/oai_formats.txt
	else
		# The file is empty.
		oai_format_file=$formats_file
	fi

	if [ $do_harvest == "yes" ]
	then
		while IFSa="" read -r oai_format || [ -n "$oai_format" ]
		do
			printf '%s\n' "$oai_format"
			~/go/bin/metha-sync -max-empty-responses 2 -format $oai_format $oai_url
			mkdir -p $asset_dir/sucho-$git_repo/$oai_format
			~/go/bin/metha-cat -format $oai_format $oai_url > $asset_dir/sucho-$git_repo/$oai_format.xml
			# git -C $git_dir/sucho-$git_repo add $oai_format.xml
			~/go/bin/metha-files -format $oai_format $oai_url > $git_dir/sucho-$git_repo/$oai_format-file_list.txt

			while IFSf="" read -r file_list || [ -n "$file_list" ]
			do
				rsync $file_list  $git_dir/sucho-$git_repo/$oai_format/
			done < $git_dir/sucho-$git_repo/$oai_format-file_list.txt

			git -C $git_dir/sucho-$git_repo add $oai_format/*

		done < $oai_format_file
	fi
	git -C $git_dir/sucho-$git_repo commit -am 'auto'
	git -C $git_dir/sucho-$git_repo push
	#b2 sync $asset_dir/ $b2_folder
done < $hosts_file
