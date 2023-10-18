# Raspagem de dados com R: rvest, RSelenium e mais - SEMEST-13

Este repositório contém o material para o Minicurso de Raspagem de dados com R utilizando as bibliotecas `rvest` e `RSelenium`, durante a SEMEST-13 da Universidade Federal Fluminense.

## Pré-requisitos

- Conhecimento básico de `R`;
- Pacotes `rvest`, `RSelenium` e `wdman`;

## Exemplos de scraping de dados de diferentes tipos de sites
- IMDB
- Airbnb
- Quotes to Scrape

## Estrutura do Repositório

- `data/`: Exemplo de dados;
- `presentation/`: Apresentações em formato PDF ou PPT;
- `source/`: Códigos de exemplo utilizados durante o curso. Links e materiais adicionais relevantes.

## SelectorGadget

`SelectorGadget` é um `bookmarklet JavaScript` que permite interativamente descobrir qual seletor CSS você precisa para extrair componentes desejados de uma página. Para utilizar, copie o código abaixo e adicione a sua barra de favoritos.

```
javascript:(function()%7Bvar%20s=document.createElement('div');s.innerHTML='Loading...';s.style.color='black';s.style.padding='20px';s.style.position='fixed';s.style.zIndex='9999';s.style.fontSize='3.0em';s.style.border='2px%20solid%20black';s.style.right='40px';s.style.top='40px';s.setAttribute('class','selector_gadget_loading');s.style.background='white';document.body.appendChild(s);s=document.createElement('script');s.setAttribute('type','text/javascript');s.setAttribute('src','https://dv0akt2986vzh.cloudfront.net/unstable/lib/selectorgadget.js');document.body.appendChild(s);%7D)();
```

## Contribuições

Contribuições são bem-vindas! Se você encontrar um erro, tem uma sugestão ou quer adicionar algo novo, por favor, sinta-se à vontade para abrir uma "issue" ou enviar um "pull request".