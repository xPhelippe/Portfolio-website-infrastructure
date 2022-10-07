server {

	listen 443 ssl http2;
	ssl_certificate /etc/letsencrypt/live/xphelippe.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/xphelippe.com/privkey.pem;

	root /var/www/html/xphelippe.com;
				# Defines the file to use as index page
        index index.html index.htm;
				# Defines the domain or subdomain name. 
        # If no server_name is defined in a server block then 
				# Nginx uses the 'empty' name
        server_name xphelippe.com www.xphelippe.com;

        location / {
            # Return a 404 error for instances when the server receives 
						# requests for untraceable files and directories.
		try_files $uri /index.html;
        }
}


server {
	listen 443 ssl http2;


	ssl_certificate /etc/letsencrypt/live/xphelippe.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/xphelippe.com/privkey.pem;

	server_name *.xphelippe.com;

	return 301 https://xphelippe.com$request_uri;
}
