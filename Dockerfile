FROM centos:6.6
RUN curl -o /etc/yum.repos.d/shibboleth.repo http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/security:shibboleth.repo
RUN yum install python-setuptools mod_ssl shibboleth.x86_64 -y && easy_install supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY localhost.crt /etc/pki/tls/certs/localhost.crt
COPY localhost.key /etc/pki/tls/private/localhost.key
COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
COPY test.conf /etc/httpd/conf.d/test.conf
COPY secure /var/www/html/secure
EXPOSE 443
CMD ["/usr/bin/supervisord"]
