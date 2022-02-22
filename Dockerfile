FROM ocaml/opam

EXPOSE 8080

RUN sudo apt -y update
RUN sudo apt -y install nodejs npm
RUN sudo apt -y upgrade m4

WORKDIR /code

COPY ./app /code
RUN sudo npm install
RUN npx esy

ENTRYPOINT npx esy start

