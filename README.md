# Agenda de Produtos

Aplicativo que agenda produtos por imagem e cita preços. 

## Conhecimentos Adquiridos nesse projeto 

Conhecimento em widgets do Material Design que identifica no Cupertino a implementação das diretrizes de interface humana para o android, pelo widget foi feito o controle de estado. Este tipo de widget não possibilitou as alterações dinâmicas, que alinhou o comportamento da interface estática.Eles foram 
utilizados para a criação de estruturas não mutáveis nos aplicativos (telas, menus, imagens etc.), ou seja, para capturar informações vindas de entradas de dados dos produtos, notificando captura de camêra 
para os demais produtos inseridos pelo usuário, onde ele vai receber uma lista de itens para notificação de preços. 

Foi usuado um Formfield para a elaboração de um formulário, onde intensifica a captura dos dados em um banco de dados do sqflite e transforma em uma lista de itens, pelo propŕio list view. 

Foi usado o List View que é o widget de rolagem. Ele exibe seus filhos um após o outro na direção de rolagem. No eixo transversal, os filhos são obrigados a preencher o ListView. Se não for nulo, o itemExtent força os filhos a terem a extensão especificada na direção de rolagem. Se não for nulo, o protótipoItem força os filhos a terem a mesma extensão que o widget fornecido na direção de rolagem. Especificar um itemExtent ou um protótipoItem é mais eficiente do que permitir que os filhos determinem sua própria extensão porque o mecanismo de rolagem pode fazer uso do conhecimento prévio da extensão dos filhos para economizar trabalho, por exemplo, quando a posição de rolagem muda drasticamente. Você não pode especificar ambos itemExtent e protótipoItem, apenas um ou nenhum deles.

## Dificuldades com o Flutter 

Emulação do App para o celular, pois teria que atualizar os pacotes do aplicativo para realizar o procedimento de uso do app no celular 

## Tecnologias Utilizadas

-[Dart](https://dart.dev/guides) 

-[Flutter](https://docs.flutter.dev/)

## Recursos do Dart + Flutter 

-[Provider](https://pub.dev/packages/provider) 

-[Http](https://www.alura.com.br/conteudo/flutter-comunicacao-http) 

-[Cupertino_Icons](https://pub.dev/packages/cupertino_icons) 

-[image_picker](https://pub.dev/packages/image_picker) 

-[url_launcher](https://pub.dev/packages/image_picker) 

## Banco do Projeto 

-[sqflite](https://api.b7web.com.br/flutter1wb/) 

## Versão do Dart, Sdk e Flutter 

Dart - 3.0.5
Flutter - 3.10.5
DevTools - 2.23.1

## Baixar e visualizar o Projeto 

  ```bash 
  
  $ fazer um git clone do projeto pelo terminal ou baixar e obter via winrar  
  
  $ Obter o Android Studio ou VsCode instalado na sua maquina
  
  $ Obter Java Jre e Jdk na versão 11.0 ou outras versões para ter o Android Instalado 

  $ Obter a Api do Android de 30 pra cima, com o intuito de rodar o aplicativo
  
  $ Ativar o modulo desenvolvedor do Android no seu celular para testar o aplicativo 
  
  ```
  
  ## Como executar o projeto no Flutter no terminal ou vscode

```bash
    # clonar repositório
    git clone https://github.com/ghdss26/Agenda_Produtos.git

    # entrar na pasta do projeto cdp
    cd Agenda_Produtos 

    # executar o projeto
    flutter run

    Obs: Só siga esses passos, caso tenha o android Studio instalado e se for usuário linux 
```
