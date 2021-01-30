FROM python:3.6
ADD . /code
WORKDIR /code
RUN apt-get update
RUN pip install -r requirements.txt
CMD python manage.py