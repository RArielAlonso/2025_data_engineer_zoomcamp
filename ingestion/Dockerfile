FROM python:3.9.1

WORKDIR /app

RUN pip install --upgrade pip
ADD requeriments.txt requeriments.txt
RUN pip install -r requeriments.txt


COPY main.py main.py

ENTRYPOINT [ "python","main.py"]