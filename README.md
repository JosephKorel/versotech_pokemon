# Versomon

Aplicativo que lista os pokémons da PokeApi e mostra detalhes sobre eles.

## Sobre

Este projeto foi feito para o processo seletivo de Desenvolvedor Flutter da empresa Versotech.

## Estrutura do Projeto

Foi utilizado [MobX](https://pub.dev/packages/mobx) para gerenciamento de estado e [GetIt](https://pub.dev/packages/get_it) para injeção de dependências
e também para estabelecer contato entre as Stores.

### Para a lista principal há três Stores que interagem entre si:

- **Pagination Store**: Responsável por determinar o offset e limit da requisição para a Api. Quando o usuário atinge o fim da lista, o offset dela passa a ser
  a quantidade de pokemons atuais. Então no próximo batch vão vir offset + limit pokémons.
- **Pokemon State Store**: Responsável por fazer a chamada para a Api e receber os pokémons. Cada vez que há uma mudança na paginação, essa Store vai reagir e fazer uma nova chamada.
- **Pokemon List Store**: Responsável pela lista de pokémons. Cada vez que há novos pokémons, essa Store vai ser chamada e adicionára à lista. E cada vez que o seu estado mudar, ela vai salvar no local storage os pokémons.

### Para a página do pokémon há duas Stores:

- **Loaded Pokemons Store**: Responsável pela lista de pokémons que o usuário navegou. Isso evita que uma nova chamada seja feita para um Pokémon já visto.
- **Single Pokemon Store**: Responsável por fazer a chamada para a Api para obter os detalhes do pokémon sendo visto. Se a chamada for bem sucedida, irá adicionar à **Loaded Pokemons Store**.

Por fim, há também a **Theme Store** que é responsável pelo tema claro, escuro ou padrão do sistema. Há também a **Pokemon Color Store** que é responsável por obter um `ColorScheme` baseado na cor do Pokémon. Cada Pokémon em seu init state irá atualizar a Store com sua cor.

## Pastas

- **data**: Comunicação com api.
- **domain**: Interfaces para implementações e usecases.
- **models**: Entidades em geral.
- **shared_pref**: Implementação do uso do local storage para salvar tema e lista de pokémons.
- **stores**: Stores que a aplicação utiliza.
- **theme**: As cores do projeto e extensões no `BuildContext` relativas a interface, como estilos, animações e etc.
- **usecase**: Implementação dos usecases.
- **utils**: Qualquer coisa que seja frequentemente utilizada durante o projeto. Neste caso foi uma extensão no `BuildContext` para reduzir o boiler plate de navegção.
- **views**: As páginas do projeto. Dentro de cada página tem a pasta _widgets_ que tem os widgets que são utilizados apenas ali. Há também a pasta _controller_ em que eu pus alguns mixins para manter a lógica e UI mais separada.

## Pacotes Utilizados

- [**MobX**](https://pub.dev/packages/mobx): Gerenciamento de Estado
- [**Get It**](https://pub.dev/packages/get_it): Injeção de Dependências e comunicação entre Stores
- [**Cached Network Image**](https://pub.dev/packages/cached_network_image): Pra facilitar o carregamento de imagens
- [**Dio**](https://pub.dev/packages/dio): Requisições HTTP
- [**Mocktail**](https://pub.dev/packages/mocktail): Testes
- [**Flutter Animate**](https://pub.dev/packages/flutter_animate): Animações
- [**Spider Chart**](https://pub.dev/packages/spider_chart): Gráfico de status do Pokémon
- [**Audioplayers**](https://pub.dev/packages/audioplayers): Reproduzir o som do Pokémon
- [**Shared Preferences**](https://pub.dev/packages/shared_preferences): Salvar localmente tema e lista de Pokémons
