# Doom Emacs — configuração pessoal

Submódulo de [dotfiles](https://github.com/joaobertholino/dotfiles), em `~/.config/doom`, usado no desktop Gentoo com Hyprland. Estado conferido em **25/10/2026**.

Este repositório contém a configuração pessoal. O Emacs, o framework Doom em `~/.config/emacs`, os pacotes baixados e os programas externos têm instalação separada.

## Conteúdo

| Arquivo/diretório | Função |
| --- | --- |
| `init.el` | Módulos de interface, edição, ferramentas e linguagens |
| `config.el` | Tema, dashboard, projetos, LaTeX, Org, Citar, Markdown e Copilot |
| `packages.el` | Declarações de pacotes adicionais e receitas |
| `custom.el` | Personalizações do Emacs Custom, CUA e divisão de janelas |
| `snippets/LaTeX-mode/` | Snippets LaTeX |
| `logo-splash/` | Imagens do dashboard |
| `catalogo/` | Material auxiliar versionado junto à configuração |

## Recursos configurados

- Tema `doom-dracula`, dashboard e workspaces.
- Evil, Corfu/Orderless, Vertico, snippets, formatação ao salvar e indicação de alterações Git.
- Magit/Forge, LSP com opções Eglot/booster, tree-sitter, PDF Tools e Vterm.
- Módulos de C/C++, Common Lisp, Emacs Lisp, LaTeX, Lean, Python, Org, Markdown, JSON, YAML, shell e web.
- Org em `~/Org-Notes`, agenda e captura de tarefas/projetos.
- Citar com bibliografia, PDFs e notas pessoais.
- Dashboard com criação de projetos, terminal e navegador Zen.
- Copilot em modos de programação; sua autenticação é feita fora do repositório.

Pacotes declarados em `packages.el`: `math-preview`, `yasnippet-snippets`, `citar`, `citar-embark`, `wc-mode`, `pandoc-mode`, `lean4-mode` e `copilot`.

A descoberta de projetos foi ajustada para remover `.git` da lista de marcadores bottom-up do Projectile, evitando que o repositório da home englobe projetos pessoais por esse marcador. Revise esse ajuste se usar a configuração fora desta organização.

## Instalar e sincronizar

Instale uma versão compatível do Emacs e o framework Doom. O checkout pessoal fica em `~/.config/doom`; faça backup de qualquer configuração existente antes de substituí-la.

No repositório principal:

```sh
git submodule update --init --recursive .config/doom
```

Para um destino vazio e instalação independente:

```sh
git clone git@github.com:joaobertholino/doom.git "$HOME/.config/doom"
```

Depois de instalar o framework e posicionar a configuração:

```sh
doom sync
```

Reinicie o Emacs após mudanças em módulos/pacotes. O script `doom` desta máquina é um wrapper em `/usr/local/bin/doom` para `~/.config/emacs/bin/doom`; o wrapper e o framework não são fornecidos por este submódulo.

## Editor padrão no Gentoo

A máquina utiliza Emacs PGTK 31.1 pré-compilado e o daemon `emacs.service`. A configuração foi confirmada no daemon em execução.

| Integração local | Comando/configuração |
| --- | --- |
| Editor de terminal | `EDITOR=/usr/local/bin/doom-editor-terminal` |
| Editor gráfico | `VISUAL=/usr/local/bin/doom-editor` |
| Git | `core.editor=/usr/local/bin/doom-editor` |
| Arquivos de texto/código | Associação MIME com `doom-emacs.desktop` |
| Ambiente persistente | `/etc/env.d/50emacs` e ambiente do Hyprland |

Os dois wrappers usam `emacsclient` e atendem pelo daemon existente; se ele não estiver disponível, têm o Emacs como alternativa. Os wrappers, a entrada desktop e a unidade global do daemon são componentes da instalação Gentoo e ficam fora deste repositório.

Comandos de operação na máquina atual:

```sh
systemctl --user status emacs.service
emacsclient --eval '(bound-and-true-p doom-user-dir)'
doom-editor arquivo.txt
doom-editor-terminal arquivo.txt
```

`systemctl --user restart emacs.service` encerra o daemon e suas sessões; salve os buffers antes de reiniciar.

## Programas externos

| Recurso | Dependências/referências |
| --- | --- |
| LaTeX | TeX Live, `latexmk`, LuaLaTeX, `texlab`, `aspell` com `pt_BR` |
| Markdown | `pandoc` |
| Common Lisp | SBCL, instalado como `sbcl` e `lisp` |
| Lean 4 | `lean`, `lake` e o pacote `lean4-mode` |
| Dashboard e terminal | `zen-browser`, backend Vterm e shell |
| Copilot | Node/servidor e autenticação compatíveis com o pacote |

Lean 4.35.0, SBCL 2.6.8 e JDK Temurin 27.0.1.0.2+1 estão instalados na máquina. Isso não significa que todos os modos ou servidores de linguagem estejam configurados automaticamente: `init.el` ainda contém `(lean +lsp +v3)`, além da declaração separada de `lean4-mode`. Revise essa combinação ao trabalhar com projetos Lean 4. O módulo Java não está habilitado em `init.el`.

O ambiente Java usa `JAVA_HOME=/opt/jdk-current`. `doom sync` resolve os pacotes Emacs declarados, mas não instala os programas externos desta tabela.

## LaTeX e dados pessoais

A configuração utiliza compilação contínua com `latexmk -pvc -lualatex`, atualização do PDF e integração com Texlab. Ela também configura limpeza de auxiliares; confira o comportamento antes de usar em projetos com artefatos que precisam ser preservados.

Adapte, quando necessário:

- nome e e-mail em `config.el`;
- `~/Org-Notes/`, agenda e arquivos de captura;
- o diretório escolhido na criação de projetos;
- `~/Documents/refs.bib`, `~/Documents/papers/` e `~/Documents/notes/`;
- caminhos de imagens em `logo-splash/` e o comando `zen-browser`;
- fonte, dicionário e ferramentas externas disponíveis no seu sistema.

## Manutenção e Git

Alterações em `init.el` ou `packages.el` exigem `doom sync`. Para mudanças em `config.el`, recarregue ou reinicie a configuração conforme o recurso alterado.

Este submódulo usa a branch `main` e o remoto `personal` na máquina atual. O script `~/.local/bin/auto-push.sh` do repositório principal publica os submódulos antes do pai, a cada hora pelo systemd. Não é necessário manter um segundo timer neste repositório.

Para manutenção manual, revise `git status` e `git diff`, publique neste repositório e depois atualize sua referência no `dotfiles`. `git submodule update` pode deixar HEAD destacado; escolha uma branch antes de editar. Backups e o histórico Git permitem recuperar a configuração pessoal, mas não restauram por si só o framework ou os pacotes externos.
