# erpnext

Erpnext docker image

* Based on: debian:8 (jessie)
* Including services: 
  * Redis
  * Nginx
  * memcached
  * Maridb
  * cron
 
Install with:


## create a data container. It stores the erpnext site, the corresponding database as well as the apps folder
`docker create -v /home/frappe/frappe-bench/sites/site1.local/ -v /var/lib/mysql -v /home/frappe/frappe-bench/apps --name erpdata vmrs/erpnext:deb8
`
## run erpnext
`docker run -d -p 80:80 --name erpnext --volumes-from erpdata vmrs/erpnext:deb8
`

## get passwords
`docker exec -ti erpnext cat /root/frappe_passwords.txt
`
Login on http://localhost with Administrator / password

####
