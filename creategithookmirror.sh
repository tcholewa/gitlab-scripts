#!/bin/bash
GITREPO=`pwd`
GITUSER=$1
SSHKEY=$2
GITREPONAME=$3

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: creategithookmirror GitUser SSHkeyAlias GitRepoName"
    exit
fi

echo "current dir: $GITREPO"

mkdir custom_hooks
chown git:git custom_hooks
cd custom_hooks
touch post-receive
chown git:git post-receive
chmod +x post-receive

echo "#!/usr/bin/env ruby" >> post-receive
echo "" >> post-receive
echo "begin" >> post-receive
echo "    pid = spawn(\"cd $GITREPO; git push --mirror git@$SSHKEY:/$GITUSER/$GITREPONAME.git\")" >> post-receive
echo "    Process.detach(pid)" >> post-receive
echo "rescue Exception => e" >> post-receive
echo "end" >> post-receive

echo "OK"

