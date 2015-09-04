FROM monasca/demo
MAINTAINER Jamie Bird <j.bird1@lancaster.ac.uk>

WORKDIR /
RUN git clone https://github.com/biirdy/monasca-anomaly.git

WORKDIR /monasca-anomaly
RUN pip install -r requirements.txt

RUN python setup.py install

CMD['service monasca-anomaly-engine start']
