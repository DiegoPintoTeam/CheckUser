#!/bin/bash
#INSTALA PACOTES
echo -ne "\033[1;32m INSTALADOR CHECKUSER FREE...\033[1;37m ";
sleep 5;
sudo apt-get update
sudo apt-get install curl
apt install nodejs
apt install npm
cd /etc
mkdir checkuser;
clear;
chmod +x iptables.sh;
cd /etc/checkuser
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 16

#SETCONFIG FUNCAO
set_config () {
echo -ne "\033[1;32m INFORME A SENHA DO BANCO DE DADOS DO PAINEL (PHPMYADMIN/MYSQL)\033[1;37m: "; read name
sed -i "s;1234;$name;g" /root/checkuser/.env > /dev/null 2>&1
}

#END FUNCAO
finalizar () {
#CRONTAB
echo '* * * * * root cd /root/checkuser && ./startcheck.sh' >> /etc/crontab
service cron reload;
service cron restart;
rm -rf install_script.sh;
#rm -rf iptables.sh;

#INICIA SERVIDOR
./startcheck.sh
clear;
echo -ne "\033[1;32m FINALIZADO!\033[1;37m ";
echo "";
echo "Se deseja alterar a porta ou senha,basta editar o arquivo /root/checkuser/.env";
}

#EXECUTA FUNCAO
set_config;


#FINALIZAR
finalizar;

