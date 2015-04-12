function boot_project {
	echo "To boot a project I'll need root access... "
	sudo echo "Thanks..." 

	# Get Project Name
	echo "What is the project name would you like to boot? "
	read project

	# My Sql DB
	echo -n "What is the user of your mysql admin? "
	read user
	echo -n "What is the password of your mysql admin? "
	if read -s pass; then
		mysqladmin --host='localhost' -u $user --password=$pass create $project
	fi

	# Setup vhosts
	NEW_SITE_CONF="/etc/apache2/sites-available/${project}.dev.conf"
	DEFAULT_SITE_CONF='/etc/apache2/sites-available/[site].dev.conf'
	sudo cp ${DEFAULT_SITE_CONF} ${NEW_SITE_CONF}
	sudo sed -i "s/\[site\]/${project}/g" ${NEW_SITE_CONF}

	sudo bash -c 'echo 127.0.0.1 ${0}".dev" >> /etc/hosts' ${project}

	sudo a2ensite ${project}'.dev.conf'
	sudo service apache2 restart 

	# Setup project file
	mkdir $HOME/work/sites/${project}
	cd $HOME/work/sites/${project}
	yo fixate-pw

	cd $HOME/work/server
	ln -s ../sites/${project}/src ./${project}
	cd $HOME/work/sites/${project}

	echo "done!"
}
