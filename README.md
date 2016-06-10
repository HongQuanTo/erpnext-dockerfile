#
# this is experimental

The idea is to make it possible to update erpnext by processing `docker pull vrms/erpnext:deb8` (assuming that there is a new build availabl) and then running a new container based on that new image using the old datacontainer with all persitent data (site, database & apps)

I am no sure that this actually works though yet

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


## create a data container
`docker create -v /home/frappe/frappe-bench/sites/ -v /var/lib/mysql/ -v /home/frappe/frappe-bench/logs --name erpdata vrms/erpnext:deb8_5
`

the data contaier stores changes to the erpnext site, the corresponding database as well as the apps folder

## run erpnext
`docker run -d -p 80:80 --name erpnext --volumes-from erpdata vrms/erpnext:deb8_5
`

## get passwords
`docker exec -ti erpnext cat /root/frappe_passwords.txt
`
Login on http://localhost with Administrator / password

####
