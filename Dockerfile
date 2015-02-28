FROM centos:6.6
RUN curl -o /etc/yum.repos.d/shibboleth.repo http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/security:shibboleth.repo
RUN yum install python-setuptools mod_ssl shibboleth.x86_64 -y && easy_install supervisor
COPY . /root
RUN cp /root/supervisord.conf /etc/ && \ 
    cp /root/server.crt /etc/pki/tls/certs/localhost.crt && \
	cp /root/server.crt /etc/shibboleth/sp-cert.pem && \
	cp /root/server.pem /etc/pki/tls/private/localhost.key && \
	cp /root/server.pem /etc/shibboleth/sp-key.pem && \
	cp /root/idp-metadata.xml /etc/shibboleth/ && \
	cp /root/shibboleth2.xml /etc/shibboleth/ && \
	cp /root/attribute-map.xml /etc/shibboleth/ && \
	cp /root/secure.conf /etc/httpd/conf.d/ && \
	cp -r /root/secure /var/www/html && \
    cp /root/ca.crt /etc/pki/ca-trust/source/anchors/ && \
	update-ca-trust enable && \
	update-ca-trust extract && \
	cat /root/ca.crt >> /etc/pki/tls/certs/localhost.crt
EXPOSE 443
CMD ["/usr/bin/supervisord"]
