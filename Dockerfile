# FROM ruby:slim

# # uncomment these if you are having this issue with the build:
# # /usr/local/bundle/gems/jekyll-4.3.4/lib/jekyll/site.rb:509:in `initialize': Permission denied @ rb_sysopen - /srv/jekyll/.jekyll-cache/.gitignore (Errno::EACCES)
# ARG GROUPID=901
# ARG GROUPNAME=ruby
# ARG USERID=901
# ARG USERNAME=jekyll

# ENV DEBIAN_FRONTEND noninteractive

# LABEL authors="Amir Pourmand,George Araújo" \
#       description="Docker image for al-folio academic template" \
#       maintainer="Amir Pourmand"

# # uncomment these if you are having this issue with the build:
# # /usr/local/bundle/gems/jekyll-4.3.4/lib/jekyll/site.rb:509:in `initialize': Permission denied @ rb_sysopen - /srv/jekyll/.jekyll-cache/.gitignore (Errno::EACCES)
# # add a non-root user to the image with a specific group and user id to avoid permission issues
# RUN groupadd -r $GROUPNAME -g $GROUPID && \
#     useradd -u $USERID -m -g $GROUPNAME $USERNAME

# # install system dependencies
# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends \
#         build-essential \
#         curl \
#         git \
#         imagemagick \
#         inotify-tools \
#         locales \
#         nodejs \
#         procps \
#         python3-pip \
#         zlib1g-dev && \
#     pip --no-cache-dir install --upgrade --break-system-packages nbconvert

# # clean up
# RUN apt-get clean && \
#     apt-get autoremove && \
#     rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*  /tmp/*

# # set the locale
# RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
#     locale-gen

# # set environment variables
# ENV EXECJS_RUNTIME=Node \
#     JEKYLL_ENV=production \
#     LANG=en_US.UTF-8 \
#     LANGUAGE=en_US:en \
#     LC_ALL=en_US.UTF-8

# # create a directory for the jekyll site
# RUN mkdir /srv/jekyll

# # copy the Gemfile and Gemfile.lock to the image
# ADD Gemfile.lock /srv/jekyll
# ADD Gemfile /srv/jekyll

# # set the working directory
# WORKDIR /srv/jekyll

# # install jekyll and dependencies
# RUN gem install --no-document jekyll bundler
# RUN bundle install --no-cache

# EXPOSE 8080

# COPY bin/entry_point.sh /tmp/entry_point.sh

# # uncomment this if you are having this issue with the build:
# # /usr/local/bundle/gems/jekyll-4.3.4/lib/jekyll/site.rb:509:in `initialize': Permission denied @ rb_sysopen - /srv/jekyll/.jekyll-cache/.gitignore (Errno::EACCES)
# # set the ownership of the jekyll site directory to the non-root user
# USER $USERNAME

# CMD ["/tmp/entry_point.sh"]



FROM ruby

ARG GROUPID=1000
ARG GROUPNAME=damn
ARG USERID=1000
ARG USERNAME=damn

ENV DEBIAN_FRONTEND=noninteractive

LABEL authors="Amir Pourmand,George Araújo" \
      description="Docker image for al-folio academic template" \
      maintainer="Amir Pourmand"

# create non-root user
RUN groupadd -r $GROUPNAME -g $GROUPID && \
    useradd -u $USERID -m -g $GROUPNAME $USERNAME

# install system dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        imagemagick \
        inotify-tools \
        locales \
        nodejs \
        procps \
        python3-pip \
        zlib1g-dev && \
    pip --no-cache-dir install --upgrade --break-system-packages nbconvert && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# set locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV EXECJS_RUNTIME=Node \
    JEKYLL_ENV=production \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# create directories owned by the user
RUN mkdir -p /srv/jekyll && chown -R $USERNAME:$GROUPNAME /srv/jekyll

# switch to non-root user
USER $USERNAME
WORKDIR /srv/jekyll

# copy Gemfile and Gemfile.lock
COPY --chown=$USERNAME:$GROUPNAME Gemfile Gemfile.lock /srv/jekyll/

# configure Bundler to install gems in a local folder inside user's home
RUN bundle config set --local path 'vendor/bundle' && \
    gem install --no-document jekyll bundler && \
    bundle install --jobs 4 --retry 3

# copy entrypoint
COPY --chown=$USERNAME:$GROUPNAME bin/entry_point.sh /tmp/entry_point.sh

EXPOSE 8080

CMD ["/tmp/entry_point.sh"]
