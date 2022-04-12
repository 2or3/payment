FROM ocaml/opam

EXPOSE 8080

RUN sudo apt -y update
RUN sudo apt -y install nodejs npm pkg-config
RUN sudo apt -y upgrade m4

WORKDIR /code

COPY ./app /code
RUN opam pin add aws ./lib/ocaml-aws/.
RUN opam update aws

RUN npm install esy
RUN npx esy

ENTRYPOINT npx esy start