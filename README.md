# Prevendo a Eficiencia de Extintores de Incêndio

Este projeto faz parte da Formação Cientista de Dados da Data Science Academy.

Fontes de dados:

https://www.muratkoklu.com/datasets/vtdhnd07.php

Detalhes do dataset:

O conjunto de dados foi obtido como resultado dos testes de extinção de quatro chamas de combustíveis diferentes com um sistema de extinção de ondas sonoras. O sistema de extinção de incêndio por ondas sonoras consiste em 4 subwoofers com uma potência total de 4.000 Watts. Existem dois amplificadores que permitem que o som chegue a esses subwoofers como amplificado. A fonte de alimentação que alimenta o sistema e o circuito do filtro garantindo que as frequências de som sejam transmitidas adequadamente para o sistema está localizada dentro da unidade de controle. Enquanto o computador é usado como fonte de frequência, o anemômetro foi usado para medir o fluxo de ar resultante das ondas sonoras durante a fase de extinção da chama e um decibelímetro para medir a intensidade do som. Um termômetro 
infravermelho foi utilizado para medir a temperatura da chama e da lata de combustível, e uma câmera é instalada para detectar o tempo de extinção da chama. Um total de 17.442 testes foram realizados com esta configuração experimental. Os experimentos foram planejados da seguinte forma:

Três diferentes combustíveis líquidos e combustível GLP foram usados para criar a chama.

5 tamanhos diferentes de latas de combustível líquido foram usados para atingir diferentes tamanhos de chamas.

O ajuste de meio e cheio de gás foi usado para combustível GLP.

Durante a realização de cada experimento, o recipiente de combustível, a 10 cm de distância, foi movido para frente até 190 cm, aumentando a distância em 10 cm a cada vez. Junto com o recipiente de combustível, o anemômetro e o decibelímetro foram movidos para frente 
nas mesmas dimensões.

Experimentos de extinção de incêndio foram conduzidos com 54 ondas sonoras de frequências diferentes em cada distância e tamanho de chama.

Ao longo dos experimentos de extinção de chama, os dados obtidos de cada dispositivo de medição foram registrados e um conjunto de dados foi criado. O conjunto de dados inclui as características do tamanho do recipiente de combustível representando o tamanho da chama, tipo de combustível, frequência, decibéis, distância, fluxo de ar e extinção da chama.

### Objetivo do projeto

O objetivo deste projeto é construir um modelo de Machine Learning que seja capaz de prever a eficiência de extintores elétricos.

### Documentação e Resutados

A documentação do projeto está disponível no link:

https://rpubs.com/CoelhoPedro/1019665