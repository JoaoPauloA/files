sudo apt-get update
JAVA_JDK=$(which java)
if [ "$JAVA_JDK" == "" ]
then
	echo -e " Installing Java11\n"
	sudo apt-get install openjdk-11-jdk -y
else
	echo -e "\n Java11 already installed!!!\n"
fi

GIT=$(which git)
if [ "$GIT" == "" ]
then
	echo -e " Installing git\n"
	sudo apt-get install git -y
else
	echo -e "\n git already installed!!!\n"
fi

MONGODB=$(which mongo)
if [ "$MONGODB" == "" ]
then
	echo -e " Installing MongoDB\n"
	sudo apt-get install mongodb -y
else
	echo -e " MongoDB already installed!!!\n"
fi

NVM=$(nvm)
if [ "$NVM" == *"not found"* ]
then
	echo -e " Installing nvm\n"
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	echo 'Aqui'
	source ~/.profile
	nvm install node
else
	echo -e " nvm already installed!!!\n"
fi

#Install Eclipse 
wget -c http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
sudo tar -zxvf eclipse.tar.gz -C /opt/
sudo mv /opt/eclipse*/ /opt/eclipse
sudo wget https://dl2.macupdate.com/images/icons128/11662.png -O /opt/eclipse/eclipse.png
echo -e '[Desktop Entry]\n Version=1.0\n Name=eclipse\n Exec=/opt/eclipse/eclipse\n Icon=/opt/eclipse/eclipse.png\n Type=Application\n Categories=Development' | sudo tee /usr/share/applications/eclipse.desktop
cp /usr/share/applications/eclipse.desktop ~/home

# Install Mysql
MYSQL=$(which mysql)
if [ "$MYSQL" == "" ]
then
	sudo apt install mysql-server -y
	wget https://raw.githubusercontent.com/JoaoPauloA/files/master/mysqld.cnf
	sudo mv mysqld.cnf /etc/mysql/mysql.conf.d/
	sudo mysql_secure_installation -y
	sudo service mysql restart
else
	echo -e " mysql already installed!!!"
	sleep 3s
	exit
	exit
fi

cat << EOF | mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
EOF
sudo apt-get update
sudo apt install mysql-workbench -y
