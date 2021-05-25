
#  Git

```shell
~$ git config --global user.name  #write User name
~$ git config --global user.email #write User email
~$ git config --global push.default simple
~$ git config --global core.sshcommand $(which ssh)
~$ git config --global core.editor vim

# add this line to ~/.bashrc
export PS1='\u@\h:\w:$(ls .git > /dev/null 2>&1 && git branch | grep "^*.\+$" | sed 's/*//g' | xargs -i echo \({}\)) \$'
```

Services >  OpenSSH Authentication Agent > Properties > General > Startup type > Automatic


#  Git Hub

```shell
~$ mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -t rsa
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Users/(username)/.ssh/id_rsa):"Your file name"
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:

# GitHub & CodeCommit
~$ vim ~/.ssh/config
Host github github.com
    HostName github.com
    IdentityFile ~/.ssh/"private ssh file"
    User git

Host git-codecommit.*.amazonaws.com
    User "SSH Key ID Check your AWS Console"
    IdentityFile ~/.ssh/"private ssh file"

# useful tool for copy & and paste
# https://github.com/settings/keys
# add SSH key
# clip < ~/.ssh/"Your file name" (Windows)
# pbcopy < ~/.ssh/"Your file name" (Mac)

~$ ssh -T git@github.com
    #Hi XXX! You've successfully authenticated, but GitHub does not provide shell access.

~$ git remote add origin https://github.com/UserName/RepostryName.git
~$ git fetch
~$ git merge --allow-unrelated-histories origin/master
~$ git push origin master
```

#  Git Secrets

~$ git secrets --register-aws --global

# PostgreSQL

```
~# passwd postgres
~# sudo su postgres
~# psql

postgres=# alter role postgres with password '***Your password***';
postgres=# \q

~# service postgresql start
```
