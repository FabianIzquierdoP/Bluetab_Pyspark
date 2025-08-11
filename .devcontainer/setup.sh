#!/bin/bash
set -e

# Versiones
SPARK_VERSION=3.5.0
HADOOP_VERSION=3
SPARK_ARCHIVE="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

# Instalar dependencias
apt-get update && apt-get install -y curl wget openjdk-11-jdk && apt-get clean

# Descargar e instalar Spark
wget https://downloads.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE}
tar xvf ${SPARK_ARCHIVE}
mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
rm ${SPARK_ARCHIVE}

# Variables de entorno
echo "export SPARK_HOME=/opt/spark" >> /etc/bash.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> /etc/bash.bashrc
echo "export PYSPARK_PYTHON=python3" >> /etc/bash.bashrc

# Instalar librerías Python
pip install pyspark jupyter pandas

echo "✅ Spark ${SPARK_VERSION} con Hadoop ${HADOOP_VERSION} instalado"
