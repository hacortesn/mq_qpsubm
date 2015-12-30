#!/bin/bash

aTmp=localhost
aTmp=${brokerName-$aTmp}
echo BrokerName -> $aTmp
sed -i -e "s/env_brokerName/$aTmp/" apache-activemq-5.9.0/conf/activemq.xml


aTmp=activemq
aTmp=${databaseName-$aTmp}
echo serverName -> $aTmp
sed -i -e "s/env_databaseName/$aTmp/" apache-activemq-5.9.0/conf/activemq.xml

aTmp=5432
aTmp=${portNumber-$aTmp}
echo portNumber -> $aTmp
sed -i -e "s/env_portNumber/${aTmp}/" apache-activemq-5.9.0/conf/activemq.xml

aTmp=10
aTmp=${maxConnections-$aTmp}
echo maxConnections -> $aTmp
sed -i -e "s/env_maxConnections/$aTmp/" apache-activemq-5.9.0/conf/activemq.xml


aTmp=false
aTmp=${createTablesOnStartup-$aTmp}
echo createTablesOnStartup -> $aTmp
sed -i -e "s/env_createTablesOnStartup/$aTmp/" apache-activemq-5.9.0/conf/activemq.xml

sed -i -e "s/env_serverName/${serverName}/" apache-activemq-5.9.0/conf/activemq.xml
sed -i -e "s/env_user/${user}/" apache-activemq-5.9.0/conf/activemq.xml
sed -i -e "s/env_password/${password}/" apache-activemq-5.9.0/conf/activemq.xml

sed '$ a admins=admin' apache-activemq-5.9.0/conf/groups.properties
sed '$ a admin=admin' apache-activemq-5.9.0/conf/users.properties
sed '$ a admin activemq' apache-activemq-5.9.0/conf/jmx.password

java -Xms256m -Xmx512m \
    -Dhawtio.realm=activemq \
    -Dhawtio.role=admins \
    -Dhawtio.rolePrincipalClasses=org.apache.activemq.jaas.GroupPrincipal \
    -Djava.util.logging.config.file=logging.properties \
    -Dcom.sun.management.jmxremote \
    -Dcom.sun.management.jmxremote \
    -Djava.security.auth.login.config=apache-activemq-5.9.0/conf/login.config \
    -Djava.io.tmpdir=apache-activemq-5.9.0/tmp \
    -Dactivemq.classpath=apache-activemq-5.9.0/conf \
    -Dactivemq.home=apache-activemq-5.9.0 \
    -Dactivemq.base=apache-activemq-5.9.0 \
    -Dactivemq.conf=apache-activemq-5.9.0/conf \
    -Dactivemq.data=apache-activemq-5.9.0/data \
    -jar apache-activemq-5.9.0/bin/activemq.jar \
    start
