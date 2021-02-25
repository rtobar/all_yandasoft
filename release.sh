#!/bin/sh

while getopts t:b:r: flag
do
    case "${flag}" in
        t) tag=${OPTARG};;
        b) branch=${OPTARG};;
        r) remote=${OPTARG};;
    esac
done

if [ -z "$remote" ] ;
then
    echo "Please set remote (-r remote)"
    exit 1
else
    echo "remote is ${remote}"
fi

if [ -z "$tag" ] ;
then
    echo "Please set tag (-t tag)"
    exit 1
else
    echo "tag is ${tag}"
fi

if [ -z "$branch" ] ;
then
    echo "Please set branch to base release on (-b branch)"
    exit 1
else
    echo "release based on branch ${branch}"
fi

pipeline="./git-do checkout -b ${branch}"
pipeline=" ${pipeline} && ./git-do foreach git checkout -b release/${tag} ${branch}"
pipeline=" ${pipeline} && ./git-do foreach git push --set-upstream ${remote} release/${tag}"
echo ${pipeline}
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes" && echo "${pipeline}" | /bin/sh ;;
  n|N ) echo "no" ;;
  * ) echo "invalid" ;;
esac


branches='develop master'
pipeline=''
for br in $branches ;
do
    pipeline=" ${pipeline} ./git-do checkout -b $br "
    pipeline=" ${pipeline} && ./git-do foreach git pull "
    pipeline=" ${pipeline} && ./git-do foreach git merge --no-ff release/${tag} "
    pipeline=" ${pipeline} && ./git-do foreach git tag ${tag}"
    pipeline=" ${pipeline} && ./git-do foreach git branch -d release/${tag}"
    pipeline=" ${pipeline} && ./git-do foreach git push origin $br"
done
echo ${pipeline}
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes" && echo "${pipeline}" | /bin/sh ;;
  n|N ) echo "no" ;;
  * ) echo "invalid" ;;
esac


