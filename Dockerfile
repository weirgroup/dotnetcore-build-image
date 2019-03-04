FROM docker:stable

USER root

RUN apk add --no-cache \
    ca-certificates \
    \
    # .NET Core dependencies
    krb5-libs \
    libgcc \
    libintl \
    libssl1.0 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    && apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true
ENV ASPNETCORE_ENVIRONMENT=Production

RUN apk add --update nodejs nodejs-npm

RUN npm install -g wait-on
RUN npm install -g get-ip

RUN apk add --update bash && rm -rf /var/cache/apk/*
COPY dotnet-install.sh /dotnet-install.sh
RUN chmod +x /dotnet-install.sh
RUN mkdir /usr/share/dotnet
RUN /dotnet-install.sh --install-dir /usr/share/dotnet
