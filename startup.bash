#!/usr/bin/env bash

config=application.conf
words=()

# security
words+=(para.security.ldap)
words+=(para.security.oauth.parameters)
words+=(para.security.oauth)
words+=(para.security.protected)

# storage
words+=(para.s3)
words+=(para.localstorage)
words+=(para.cassandra)
words+=(para.mongodb)
words+=(para.db)

# search
words+=(para.es)
words+=(para.lucene)
words+=(para.hc)

# others
words+=(para.azure)
words+=(para.mail)
words+=(para)

function get_key()
{
	local v=${1,,} # tolower; this enables bash 4.0 or later
	local x

	for i in "${words[@]}"
	do
		x=${i//./_}_
		if [[ $v == $x* ]]
		then
			echo $i.${v#$x}
			return 0
		fi
	done
	return 1
}

echo 'para.plugin_folder = "lib/"' >$config
env | sed -n '/^PARA_/s/=.*//p' | while read v
do
	key=$(get_key $v)
	if [[ -z $key ]]
	then
		continue
	fi

	case "${!v}" in
	true|false)
		echo "$key = ${!v}" >>$config ;;
	[0-9]*)
		echo "$key = ${!v}" >>$config ;;
	*)
		echo "$key = \"${!v}\"" >>$config ;;
	esac
done
echo '---------------'
cat $config
echo '---------------'

exec java -jar -Dconfig.file=./application.conf para.war
