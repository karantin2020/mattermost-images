# Dockerfile for github.com/mattermost/mattermost-server

FROM        golang:1.9.0-alpine3.6 as builder

ENV         GOPATH /go \
            MATTERMOST_VER=4.2.0

RUN         apk add --update git build-base; \
            go get -u -v -d github.com/mattermost/mattermost-server; \
            go get -u -v github.com/Masterminds/glide; \
            cd $GOPATH/src/github.com/mattermost/mattermost-server; \
            glide install; \
            make build-linux BUILD_NUMBER=${MATTERMOST_VER}; \
            ls $GOPATH/bin; \
            $GOPATH/bin/mattermost-server -h
            
