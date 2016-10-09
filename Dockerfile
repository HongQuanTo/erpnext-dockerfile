FROM debian:wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV FRAPPE_USER frappe
ENV ERPNEXT_APPS_JSON https://raw.githubusercontent.com/frappe/bench/master/install_scripts/erpnext-apps-master.json

RUN useradd $FRAPPE_USER && mkdir /home/$FRAPPE_USER && chown -R $FRAPPE_USER.$FRAPPE_USER /home/$FRAPPE_USER

WORKDIR /home/$FRAPPE_USER

COPY setup.sh /
RUN  bash /setup.sh

RUN apt-get update

VOLUME ["/var/lib/mysql", "/home/frappe/frappe-bench/sites/site1.local/"]
COPY all.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["/usr/bin/supervisord","-n"]
