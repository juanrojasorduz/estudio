FROM ubuntu:latest
RUN apt update && apt upgrade -y

LABEL author="sergioinfante"

WORKDIR /app

ENV NAME sergio

RUN apt install python3.10 -y

COPY *.py /app/

CMD [ "python3.10", "hello-world.py" ]