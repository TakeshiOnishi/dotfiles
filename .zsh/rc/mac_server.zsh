# apache/mysql起動 再起動
function web(){
case $1 in
	"start" )
		mysql.server start
		if [ $? -eq 0 ]; then
			echo -- MySQL START --
		fi
		sudo apachectl start
		if [ $? -eq 0 ]; then
			echo -- Apache START --
		fi
		;;
	"stop" )
		mysql.server stop
		if [ $? -eq 0 ]; then
			echo -- MySQL STOP --
		fi
		sudo apachectl stop
		if [ $? -eq 0 ]; then
			echo -- Apache STOP --
		fi
		;;
	"restart" )
		mysql.server restart
		if [ $? -eq 0 ]; then
			echo -- MySQL RESTART --
		fi
		sudo apachectl restart
		if [ $? -eq 0 ]; then
			echo -- Apache RESTART --
		fi
		;;
	* )
		echo "end: bad param"
		;;
esac
}

# mysql起動 再起動
function sql(){
case $1 in
	"start" )
		mysql.server start
		if [ $? -eq 0 ]; then
			echo -- MySQL START --
		fi
		;;
	"stop" )
		mysql.server stop
		if [ $? -eq 0 ]; then
			echo -- MySQL STOP --
		fi
		;;
	"restart" )
		mysql.server restart
		if [ $? -eq 0 ]; then
			echo -- MySQL RESTART --
		fi
		;;
	* )
		echo "end: bad param"
		;;
esac
}

