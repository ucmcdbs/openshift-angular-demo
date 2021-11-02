FROM node:14-buster-slim as builder

WORKDIR /opt/build

COPY ./ ./

RUN npm install
RUN npm build

FROM caddy:alpine

WORKDIR /opt/app

COPY --from=builder /opt/build/dist/openshift-angular-demo/ .

CMD [ "caddy", "file-server", "--listen", ":4200" ]

# expose ports
EXPOSE 4200/tcp
