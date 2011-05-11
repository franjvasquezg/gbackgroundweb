#
# Regular cron jobs for the canaima-fondo-institucional package
#
0 4	* * *	root	[ -x /usr/bin/canaima-fondo-institucional_maintenance ] && /usr/bin/canaima-fondo-institucional_maintenance
