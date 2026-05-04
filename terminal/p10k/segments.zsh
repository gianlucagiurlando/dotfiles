# ============ PROMPT SEGMENTS ============
# LEFT/RIGHT prompt element lists and all per-segment behavioral configuration.
# Colors → colors.zsh  |  Icons → symbols.zsh

# ---- PROMPT ELEMENTS ----

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon                 # os identifier
  dir                     # current directory
  vcs                     # git status
  newline                 # \n
  prompt_char             # prompt symbol (❯)
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # exit code of the last command
  command_execution_time  # duration of the last command
  background_jobs         # presence of background jobs
  direnv                  # direnv status (https://direnv.net/)
  asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
  virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
  anaconda                # conda environment (https://conda.io/)
  pyenv                   # python environment (https://github.com/pyenv/pyenv)
  goenv                   # go environment (https://github.com/syndbg/goenv)
  nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
  nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
  nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
  # node_version          # node.js version
  # go_version            # go version (https://golang.org)
  # rust_version          # rustc version (https://www.rust-lang.org)
  # dotnet_version        # .NET version (https://dotnet.microsoft.com)
  # php_version           # php version (https://www.php.net/)
  # laravel_version       # laravel php framework version (https://laravel.com/)
  # java_version          # java version (https://www.java.com/)
  # package               # name@version from package.json (https://docs.npmjs.com/files/package.json)
  rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
  rvm                     # ruby version from rvm (https://rvm.io)
  fvm                     # flutter version management (https://github.com/leoafarias/fvm)
  luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
  jenv                    # java version from jenv (https://github.com/jenv/jenv)
  plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
  perlbrew                # perl version from perlbrew (https://github.com/gugod/App-perlbrew)
  phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
  scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
  haskell_stack           # haskell version from stack (https://haskellstack.org/)
  kubecontext             # current kubernetes context (https://kubernetes.io/)
  terraform               # terraform workspace (https://www.terraform.io)
  # terraform_version     # terraform version (https://www.terraform.io)
  aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
  aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
  azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
  gcloud                  # google cloud cli account and project (https://cloud.google.com/)
  google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
  toolbox                 # toolbox name (https://github.com/containers/toolbox)
  context                 # user@hostname
  nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
  ranger                  # ranger shell (https://github.com/ranger/ranger)
  yazi                    # yazi shell (https://github.com/sxyazi/yazi)
  nnn                     # nnn shell (https://github.com/jarun/nnn)
  lf                      # lf shell (https://github.com/gokcehan/lf)
  xplr                    # xplr shell (https://github.com/sayanarijit/xplr)
  vim_shell               # vim shell indicator (:sh)
  midnight_commander      # midnight commander shell (https://midnight-commander.org/)
  nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
  chezmoi_shell           # chezmoi shell (https://www.chezmoi.io/)
  # vpn_ip                # virtual private network indicator
  # load                  # CPU load
  # disk_usage            # disk usage
  # ram                   # free RAM
  # swap                  # used swap
  todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
  timewarrior             # timewarrior tracking status (https://timewarrior.net/)
  taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
  per_directory_history   # Oh My Zsh per-directory-history local/global indicator
  # cpu_arch              # CPU architecture
  time                    # current time
  # ip                    # ip address and bandwidth usage for a specified network interface
  # public_ip             # public IP address
  # proxy                 # system-wide http/https/ftp proxy
  # battery               # internal battery
  # wifi                  # wifi speed
  # example               # example user-defined segment (see prompt_example function in p10k.zsh)
)

# ---- prompt_char ----

# Show overwrite indicator (▶) when in vi overwrite mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true

# ---- dir ----

# Shorten long directory paths by truncating to unique prefixes.
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
local anchor_files=(
  .bzr
  .citc
  .git
  .hg
  .node-version
  .python-version
  .go-version
  .ruby-version
  .lua-version
  .java-version
  .perl-version
  .php-version
  .tool-versions
  .mise.toml
  .shorten_folder_marker
  .svn
  .terraform
  CVS
  Cargo.toml
  composer.json
  go.mod
  package.json
  stack.yaml
)
typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
# Show lock icon for non-writable directories.
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

# ---- vcs (git) ----

# Don't count unstaged/untracked files in repos larger than this (negative = unlimited).
typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
# Skip git status for the home directory repo.
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

# Custom git status formatter. Output: branch wip ⇣42⇡42 *42 merge ~42 +42 !42 ?42
function my_git_formatter() {
  emulate -L zsh

  if [[ -n $P9K_CONTENT ]]; then
    # Loading or from vcs_info — VCS_STATUS_* not available.
    typeset -g my_git_format=$P9K_CONTENT
    return
  fi

  if (( $1 )); then
    # Up-to-date: use distinct colors (see colors.zsh for the palette counterparts).
    local       meta='%f'
    local      clean='%76F'   # green
    local   modified='%178F'  # yellow
    local  untracked='%39F'   # blue
    local conflicted='%196F'  # red
  else
    # Incomplete / stale: everything grey.
    local       meta='%244F'
    local      clean='%244F'
    local   modified='%244F'
    local  untracked='%244F'
    local conflicted='%244F'
  fi

  local res

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
    # Truncate branch names longer than 32 chars: first 12 … last 12.
    (( $#branch > 32 )) && branch[13,-13]="…"
    res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
  fi

  if [[ -n $VCS_STATUS_TAG
        # Show tag only when not on a branch.
        && -z $VCS_STATUS_LOCAL_BRANCH
      ]]; then
    local tag=${(V)VCS_STATUS_TAG}
    (( $#tag > 32 )) && tag[13,-13]="…"
    res+="${meta}#${clean}${tag//\%/%%}"
  fi

  # Show commit hash when there is neither branch nor tag.
  [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&
    res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

  if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
    res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
  fi

  if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
    res+=" ${modified}wip"
  fi

  if (( VCS_STATUS_COMMITS_AHEAD || VCS_STATUS_COMMITS_BEHIND )); then
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  elif [[ -n $VCS_STATUS_REMOTE_BRANCH ]]; then
    # Uncomment to show '=' when in sync with remote:
    # res+=" ${clean}="
  fi

  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
  [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
  (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
  (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

  typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

# ---- status ----

typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
# Don't show ✔ for success when prompt_char already turns green.
typeset -g POWERLEVEL9K_STATUS_OK=false
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
# Don't show ✘ for plain errors when prompt_char already turns red.
typeset -g POWERLEVEL9K_STATUS_ERROR=false
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true

# ---- command_execution_time ----

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

# ---- background_jobs ----

typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

# ---- asdf ----

typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true
typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=

# ---- nordvpn ----

# Hide when not connected.
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=

# ---- disk_usage ----

typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=90
typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=95
typeset -g POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=false

# ---- load ----

typeset -g POWERLEVEL9K_LOAD_WHICH=5

# ---- todo ----

typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=true
typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false

# ---- timewarrior ----

# Truncate task names longer than 24 chars.
typeset -g POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'

# ---- context (user@hostname) ----

typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
# Hide context unless running with privileges or via SSH.
typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

# ---- virtualenv ----

typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

# ---- anaconda ----

typeset -g POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'

# ---- pyenv ----

typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true
typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT}${${P9K_CONTENT:#$P9K_PYENV_PYTHON_VERSION(|/*)}:+ $P9K_PYENV_PYTHON_VERSION}'

# ---- goenv ----

typeset -g POWERLEVEL9K_GOENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_GOENV_SHOW_SYSTEM=true

# ---- nodenv ----

typeset -g POWERLEVEL9K_NODENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_NODENV_SHOW_SYSTEM=true

# ---- nvm ----

typeset -g POWERLEVEL9K_NVM_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_NVM_SHOW_SYSTEM=true

# ---- nodeenv ----

typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false
typeset -g POWERLEVEL9K_NODEENV_{LEFT,RIGHT}_DELIMITER=

# ---- node_version ----

typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

# ---- go_version ----

typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true

# ---- rust_version ----

typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true

# ---- dotnet_version ----

typeset -g POWERLEVEL9K_DOTNET_VERSION_PROJECT_ONLY=true

# ---- php_version ----

typeset -g POWERLEVEL9K_PHP_VERSION_PROJECT_ONLY=true

# ---- java_version ----

typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true
typeset -g POWERLEVEL9K_JAVA_VERSION_FULL=false

# ---- rbenv ----

typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_RBENV_SHOW_SYSTEM=true

# ---- rvm ----

typeset -g POWERLEVEL9K_RVM_SHOW_GEMSET=false
typeset -g POWERLEVEL9K_RVM_SHOW_PREFIX=false

# ---- luaenv ----

typeset -g POWERLEVEL9K_LUAENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_LUAENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_LUAENV_SHOW_SYSTEM=true

# ---- jenv ----

typeset -g POWERLEVEL9K_JENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_JENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_JENV_SHOW_SYSTEM=true

# ---- plenv ----

typeset -g POWERLEVEL9K_PLENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_PLENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_PLENV_SHOW_SYSTEM=true

# ---- perlbrew ----

typeset -g POWERLEVEL9K_PERLBREW_PROJECT_ONLY=true
typeset -g POWERLEVEL9K_PERLBREW_SHOW_PREFIX=false

# ---- phpenv ----

typeset -g POWERLEVEL9K_PHPENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_PHPENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_PHPENV_SHOW_SYSTEM=true

# ---- scalaenv ----

typeset -g POWERLEVEL9K_SCALAENV_SOURCES=(shell local global)
typeset -g POWERLEVEL9K_SCALAENV_PROMPT_ALWAYS_SHOW=false
typeset -g POWERLEVEL9K_SCALAENV_SHOW_SYSTEM=true

# ---- haskell_stack ----

typeset -g POWERLEVEL9K_HASKELL_STACK_SOURCES=(shell local)
typeset -g POWERLEVEL9K_HASKELL_STACK_ALWAYS_SHOW=true

# ---- kubecontext ----

# Only show when running a kubectl-related command.
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold|kubent|kubecolor|cmctl|sparkctl'
typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
    # '*prod*'  PROD
    # '*test*'  TEST
    '*'       DEFAULT)
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
# Show cloud cluster name (GKE/EKS), falling back to context name.
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
# Append namespace unless it's "default".
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

# ---- terraform ----

typeset -g POWERLEVEL9K_TERRAFORM_SHOW_DEFAULT=false
typeset -g POWERLEVEL9K_TERRAFORM_CLASSES=(
    # '*prod*'  PROD
    # '*test*'  TEST
    '*'         OTHER)

# ---- aws ----

typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|cdk|terraform|pulumi|terragrunt'
typeset -g POWERLEVEL9K_AWS_CLASSES=(
    # '*prod*'  PROD
    # '*test*'  TEST
    '*'       DEFAULT)
typeset -g POWERLEVEL9K_AWS_CONTENT_EXPANSION='${P9K_AWS_PROFILE//\%/%%}${P9K_AWS_REGION:+ ${P9K_AWS_REGION//\%/%%}}'

# ---- azure ----

typeset -g POWERLEVEL9K_AZURE_SHOW_ON_COMMAND='az|terraform|pulumi|terragrunt'
typeset -g POWERLEVEL9K_AZURE_CLASSES=(
    # '*prod*'  PROD
    # '*test*'  TEST
    '*'         OTHER)

# ---- gcloud ----

typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs|gsutil'
typeset -g POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_ID//\%/%%}'
typeset -g POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_NAME//\%/%%}'
typeset -g POWERLEVEL9K_GCLOUD_REFRESH_PROJECT_NAME_SECONDS=60

# ---- google_app_cred ----

typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform|pulumi|terragrunt'
typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=(
    # '*:*prod*:*'  PROD
    # '*:*test*:*'  TEST
    '*'             DEFAULT)
typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_CONTENT_EXPANSION='${P9K_GOOGLE_APP_CRED_PROJECT_ID//\%/%%}'

# ---- toolbox ----

# Don't display the name when it matches the default fedora-toolbox-* pattern.
typeset -g POWERLEVEL9K_TOOLBOX_CONTENT_EXPANSION='${P9K_TOOLBOX_NAME:#fedora-toolbox-*}'

# ---- vpn_ip ----

# Show only the icon, not the IP address.
typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=
typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(gpd|wg|(.*tun)|tailscale)[0-9]*|(zt.*)'
typeset -g POWERLEVEL9K_VPN_IP_SHOW_ALL=false

# ---- ip ----

typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='$P9K_IP_IP${P9K_IP_RX_RATE:+ %70F⇣$P9K_IP_RX_RATE}${P9K_IP_TX_RATE:+ %215F⇡$P9K_IP_TX_RATE}'
typeset -g POWERLEVEL9K_IP_INTERFACE='[ew].*'

# ---- battery ----

typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false

# ---- time ----

typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%I:%M:%S %p}'
typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
