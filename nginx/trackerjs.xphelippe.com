server {

	listen 443 ssl http2;
	ssl_certificate /etc/letsencrypt/live/xphelippe.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/xphelippe.com/privkey.pem;
				
				# sets the folder that the files are located in
	root /var/www/html/trackerjs.xphelippe.com;
				# Defines the file to use as index page
        index index.html index.htm;
				# Defines the domain or subdomain name.
        server_name trackerjs.xphelippe.com www.trackerjs.xphelippe.com;
	
				# sets where to search for a specified path
				# because / is the most specific, all paths will go through this
        location / {
				# because React is a SPA,
				# we will always return the index.html file
            try_files $uri /index.html;
        }
}
