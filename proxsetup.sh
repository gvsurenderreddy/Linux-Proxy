#!/bin/sh
PROXY="proxy.ssn.net"
PORT=8080

setproxy(){
  echo "Setting Proxy"
  gsettings set org.gnome.system.proxy mode 'manual'
  gsettings set org.gnome.system.proxy.http host $PROXY
  gsettings set org.gnome.system.proxy.http port $PORT
  gsettings set org.gnome.system.proxy.https host $PROXY
  gsettings set org.gnome.system.proxy.https port $PORT
  gsettings set org.gnome.system.proxy.ftp host $PROXY
  gsettings set org.gnome.system.proxy.ftp port $PORT
  gsettings set org.gnome.system.proxy.socks host $PROXY
  gsettings set org.gnome.system.proxy.socks port $PORT
  git config --global http.proxy proxy.ssn.net:8080
  git config --global https.proxy proxy.ssn.net:8080


}

unsetproxy(){
  gsettings set org.gnome.system.proxy mode 'none'
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo "Proxy Unset Successful"
}

checkproxy(){
  noflines="$(env | grep $PROXY | wc -l)"
  if [ $noflines -eq 0 ]
  then
  echo "Proxy is not Set"
  else
  echo "Proxy is set"
  fi
}

if [ $1 -eq 1 ]
then
setproxy
elif [ $1 -eq 2 ]
then
  unsetproxy
elif [ $1 -eq 3 ]
then
  env | grep "proxy"
else
  checkproxy
fi
