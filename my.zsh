ZSH_THEME="norm"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%} → %{$reset_color%}"

PROMPT='%{$fg[yellow]%}λ %{$fg[green]%}%c %{$fg[yellow]%}→ $(git_prompt_info)%{$reset_color%}'
RPROMPT='%{$fg[yellow]%}$(virtualenv_prompt_info)%{$reset_color%}%'

# neovim
alias vi='nvim'
alias vim='nvim'

# clojure
alias repl='clj -A:cider'

# lein
#alias repl='lein repl'
alias lnr='lein run'
alias lnc='lein clean'
alias lni='lein install'
alias lnt='lein test'

# docker
alias dp='docker ps'
alias dk='docker kill'
