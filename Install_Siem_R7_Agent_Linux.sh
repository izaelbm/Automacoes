#!/bin/bash

#modo de uso(executar no servidor destino)
#cd /tmp && wget http://FTP/Install_Siem_R7_agent.sh -O /tmp/Install_Siem_R7_agent.sh && chmod +x ./Install_Siem_R7_agent.sh && clear &&./Install_Siem_R7_agent.sh
echo "#Author: Izael Magalhaes - izaelbm.com.br"
echo "#Description: R7(siem) agent install"
echo "#Release v1.0 - 05/2022"
echo " "
echo " "
####VARIAVEIS######
SRVDATA="ipFTP"

#######INICIO############

#validando o acesso a internet
pingInternet=$(ping google.com -c 1 2>/dev/null)
pingSrvData=$(ping $SRVDATA -c 1 2>/dev/null)

ValpingInternet=${#pingInternet}
ValpingSrvData=${#pingSrvData}

echo "Validando acesso a Internet"
echo " "
if [ $ValpingInternet -gt "0" ]
then
	echo "[OK] Acesso a Internet"
else
	echo "[NOK] Acesso a Internet"
	exit 1
fi
echo " "
echo "Validando Acesso ao FTP"
echo " "
#validando o acesso ao SRVDATA
if [ $ValpingSrvData -gt "0" ]
then
	echo "[OK] Acesso ao SRVDATA"
else
	echo "[NOK] Acesso ao SRVDATA"
	exit 1
fi
echo " "
echo "Baixando o Instalador do Agent R7"
#Baixando o Binario de Instalacao
echo " "
wget http://$SRVDATA/Install_Siem_R7_agent.sh -O /tmp/binR7.sh
echo " "
echo" "
echo "Validando se o arquivo foi baixado"
echo " "
#validar se o arquivo foi baixado
ValBinR7=$([[ -f /tmp/binR7.sh ]] && echo "ok")

if [ $ValBinR7 = "ok" ]
then
	echo "[OK] Download efetuado com Sucesso"
else
	echo "[NOK] Erro ao efetuar o Download do Binario"
fi
echo " "
#Acessando o diretorio TMP
cd /tmp
echo "Atribuindo Permissoes de Execucao"
echo " "
#dando permissao de instalacao ao binario
chmod u+x ./binR7.sh
#echo "[OK] Permissao Atribuida com Sucesso"
echo " "
#verificando permissoes
ls -la ./binR7.sh
echo " "
#iniciando a instalacao
echo "Iniciando a Instalacao do Agent"
./binR7.sh install_start --token us:token #adicione o token aki
echo "###Instalacao Concluida###"
rm -rf binR7.sh
