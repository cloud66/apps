FROM ubuntu:14.04

# Install required packages
RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends \
      ca-certificates \
      openssh-server \
      wget \
      apt-transport-https \
      nano

# Download & Install GitLab
# If you run GitLab Enterprise Edition point it to a location where you have downloaded it.
RUN echo "deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/gitlab_gitlab-ce.list
RUN wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add -
RUN apt-get update && apt-get install -yq --no-install-recommends gitlab-ce=7.12.2~omnibus.1-1

# Manage SSHD through runit
RUN mkdir -p /opt/gitlab/sv/sshd/supervise \
    && mkfifo /opt/gitlab/sv/sshd/supervise/ok \
    && printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D" > /opt/gitlab/sv/sshd/run \
    && chmod a+x /opt/gitlab/sv/sshd/run \
    && ln -s /opt/gitlab/sv/sshd /opt/gitlab/service \
    && mkdir -p /var/run/sshd

# Prepare default configuration
RUN (echo "" \
     && echo "# Cloud 66 customizations below" \
     && echo "postgresql['enable'] = false" \
     && echo "redis['enable'] = false" \
     && echo "gitlab_rails['db_adapter'] = 'postgresql'" \
     && echo "gitlab_rails['db_encoding'] = 'unicode'" \
     && echo "gitlab_rails['db_database'] = ENV[\"POSTGRESQL_DATABASE\"]" \
     && echo "gitlab_rails['db_username'] = ENV[\"POSTGRESQL_USERNAME\"]" \
     && echo "gitlab_rails['db_password'] = ENV[\"POSTGRESQL_PASSWORD\"]" \
     && echo "gitlab_rails['db_host'] = ENV[\"POSTGRESQL_ADDRESS\"]" \
     && echo "gitlab_rails['db_port'] = 5432" \
     && echo "gitlab_rails['redis_host'] = ENV[\"REDIS_ADDRESS\"]" \
     && echo "gitlab_rails['redis_port'] = 6379" \
     && echo "gitlab_rails['gitlab_shell_ssh_port'] = 10022" \
     && echo "gitlab_rails['gitlab_ssh_host'] = ENV[\"SITE\"]") >> /etc/gitlab/gitlab.rb

# Expose web & ssh
EXPOSE 80 443 22

RUN sed -i "s/^\.*external_url.*$/external_url ENV[\"SITE\"]/" /etc/gitlab/gitlab.rb
RUN mv /etc/gitlab/gitlab.rb /tmp/gitlab.rb

# Copy assets
COPY wrapper seeder killtree /usr/local/bin/
RUN chmod 700 /usr/local/bin/wrapper /usr/local/bin/seeder /usr/local/bin/killtree

# Wrapper to handle signal, trigger runit and reconfigure GitLab
CMD ["/usr/local/bin/wrapper"]
