# Configuração Doom Emacs

Este repositório é o submódulo `doom` do projeto de dotfiles. Ele contém a **configuração pessoal**, não o framework Doom Emacs, o Emacs nem os programas externos chamados por essa configuração.

## Instalação

1. Instale Emacs e uma instalação compatível do framework Doom Emacs.
2. Clone este repositório em `~/.config/doom` ou inicialize o submódulo a partir do repositório principal:

   ```bash
   git submodule update --init --recursive .config/doom
   ```

3. Execute `doom sync` usando o binário `doom` fornecido pela sua instalação do framework e reinicie o Emacs.

O repositório não contém um script de instalação nem fixa uma versão do framework Doom. Antes de substituir uma configuração existente, faça uma cópia de `~/.config/doom`.

## Arquivos

| Arquivo/diretório | Finalidade |
| --- | --- |
| `init.el` | Módulos Doom ativados: Evil, Corfu/Vertico, LSP/Eglot, Magit, tmux, tree-sitter e linguagens como LaTeX, Lean, Python, Markdown, JSON, YAML, shell e web. |
| `config.el` | Tema Dracula, dashboard, atalhos, projetos, Org, LaTeX, Citar, Markdown/Pandoc, Vterm e Copilot. |
| `packages.el` | Pacotes adicionais: `math-preview`, `yasnippet-snippets`, `citar`, `citar-embark`, `wc-mode`, `pandoc-mode`, `lean4-mode` e `copilot`. |
| `custom.el` | Valores gerados/pessoais do Emacs Custom. |
| `snippets/LaTeX-mode/` | Snippets de LaTeX. |
| `logo-splash/` | Imagens usadas pelo dashboard. |

## Dependências referenciadas

Não há manifesto de pacotes do sistema. Os itens abaixo são mencionados diretamente pela configuração e devem ser instalados somente se você usar as respectivas funcionalidades:

| Recurso | Programa/requisito observado |
| --- | --- |
| LaTeX | `latexmk`, LuaLaTeX, `texlab`, `aspell` com dicionário `pt_BR` |
| Markdown | `pandoc` |
| Navegador pelo dashboard | `zen-browser` |
| Terminal interno | suporte a `vterm` e um backend de terminal compatível |
| Autocompletar | acesso/requisitos definidos pelo pacote `copilot.el` |
| Lean | `lean4-mode` e um ambiente Lean/LSP compatível |

Os pacotes Emacs adicionais são resolvidos por `doom sync`; dependências externas não são instaladas por ele. A origem/nome de pacote das ferramentas do sistema não é definido neste repositório.

## Dados e caminhos pessoais

Revise estes caminhos antes de usar a configuração em outra conta ou computador:

- `~/Org-Notes/`, incluindo `tarefas.org`, `projetos.org`, `task.org` e `project.org`;
- `~/Projects/`, usado pelo comando de criar projeto;
- `~/Documents/refs.bib`, `~/Documents/papers/` e `~/Documents/notes/`, usados por Citar;
- `~/.config/doom/logo-splash/doom-emacs-logo.png`;
- `zen-browser`, chamado pelo dashboard;
- `~/.config/emacs/bin` e os caminhos TeX Live adicionados pelo `.bashrc` do repositório principal.

O dashboard permite criar projetos, abrir terminal em `~` e abrir o navegador. A configuração também ativa `cua-mode` em `custom.el`; caso esse modo não esteja disponível na sua instalação, remova ou adapte essa linha antes de iniciar o Emacs.

## Operação e manutenção

Depois de alterar `init.el` ou `packages.el`, execute `doom sync`. Depois de alterar apenas `config.el`, normalmente reiniciar ou recarregar a configuração é suficiente. Mantenha este repositório atualizado com:

```bash
git pull --ff-only
doom sync
```

Não existe desinstalador. Para rollback, restaure o backup de `~/.config/doom` que foi feito antes da cópia ou use o histórico Git para voltar a um commit conhecido.

## Observações importantes

- O modo LaTeX configura compilação contínua com `latexmk -pvc -lualatex` e remove arquivos auxiliares após a compilação. Verifique esse comportamento antes de usá-lo em projetos que precisem reter artefatos.
- A configuração procura `pdf-view-mode` para PDFs e usa PDF Tools.
- Nenhuma credencial é versionada aqui. O uso de Copilot pode exigir configuração/autorização feita fora deste repositório.
