FROM ocaml/opam

RUN apt install postgresql ruby-sass
RUN opam install ocsigen-start

