# s2i-gradle-springboot
FROM openshift/base-centos7

LABEL maintainer="Khôi Tran <tran@puzzle.ch>"

ENV JAVA_VERSION 1.8.0
ENV GRADLE_OPTS="-Xmx64m -Dorg.gradle.jvmargs='-Xmx256m -XX:MaxPermSize=64m' -Dorg.gradle.daemon=false"

LABEL io.k8s.description="Platform for building gradle spring boot applications" \
      io.k8s.display-name="gradle-spring-boot-builder 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum install -y java-${JAVA_VERSION}-openjdk-devel && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

EXPOSE 8080

# CMD ["/usr/libexec/s2i/usage"]
