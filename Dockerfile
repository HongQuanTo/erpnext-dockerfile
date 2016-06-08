
FROM debian:8


ENV FRAPPE_USER frappe


ENV ERPNEXT_APPS_JSON https://raw.githubusercontent.com/frappe/bench/master/install_scripts/erpnext-apps-master.json
RUN useradd $FRAPPE_USER && mkdir /home/$FRAPPE_USER && chown -R $FRAPPE_USER.$FRAPPE_USER /home/$FRAPPE_USER

WORKDIR /home/$FRAPPE_USER

COPY setup.sh /
RUN  bash /setup.sh

RUN apt-get -y remove build-essential python-dev python-software-properties libmariadbclient-dev libxslt1-dev libcrypto++-dev \
libssl-dev  && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /home/$FRAPPE_USER/.cache

RUN  echo 'export TERM=xterm' >> /etc/bash.bashrc

VOLUME ["/var/lib/mysql/", "/home/frappe/frappe-bench/sites/", "/home/frappe/frappe-bench/apps/", "/home/frappe/frappe-bench/logs"]

COPY all.conf /etc/supervisor/conf.d/

EXPOSE 80

CMD ["/usr/bin/supervisord","-n"]
