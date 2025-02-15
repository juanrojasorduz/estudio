FROM python:3.12

WORKDIR /app

COPY . /app/

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
VOLUME /data
RUN python manage.py collectstatic --noinput

CMD [ "uvicorn", "djangophrasalverbs.asgi:application", "--host", "0.0.0.0", "--port", "8000" ]
