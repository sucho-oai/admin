#!/bin/bash

#Set your Metha extracts directory
oai_dir=~/metha-dir
git_dir=~/sucho/git
hosts_file="hosts.txt"
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
  hut git create sucho-$git_repo -v public -d $oai_url
  git clone git@git.sr.ht:~justinkelly/sucho-$git_repo $git_dir/sucho-$git_repo
	while IFSa="" read -r oai_format || [ -n "$oai_format" ]
	do
	  printf '%s\n' "$oai_format"
	  ~/go/bin/metha-sync -format $oai_format $oai_url
	  ~/go/bin/metha-cat -format $oai_format $oai_url > $git_dir/sucho-$git_repo/$oai_format.xml
	  git -C $git_dir/sucho-$git_repo add $oai_format.xml
	done < $formats_file
  git -C $git_dir/sucho-$git_repo commit -am 'auto'
  git -C $git_dir/sucho-$git_repo push
done < $hosts_file
