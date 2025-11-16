# Gruvified rkj-repos zsh theme
# Colors:
#   - Active border:   #ffbb00 (yellow)
#   - Inactive border: #333333 (dark gray)
#   - Waybar/Fastfetch: #ebdbb2 (light beige)
#   - Cherry blink:    #fb4934 (red)
#   - Concrete:        #928374 (gray)

function hg_prompt_info {
  if (( $+commands[hg] )) && [[ -e ~/.hgrc ]] && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%F{#fb4934}<branch>%f><:%F{#fb4934}<bookmark>%f>\
</%F{#ffbb00}<tags|%f,%F{#ffbb00}>%f>\
%F{#fb4934}<status|modified|unknown><update>%f<patches: <patches|join( → )|pre_applied(%F{#ffbb00})|post_applied(%f)|pre_unapplied(%F{#333333})|post_unapplied(%f)>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%F{#ebdbb2}+%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{#ffbb00}✱%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{#fb4934}✗%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{#928374}➦%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{#fb4934}✂%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{#928374}✈%f"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %F{#928374}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%f"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%F{#928374}$ZSH_THEME_GIT_PROMPT_SUFFIX "
  fi
}

function retcode() {}

# alternate prompt with git & hg
PROMPT=$'%F{#ebdbb2}┌─[%F{#ffbb00}%n%f@%F{#ebdbb2}%m%f%F{#ebdbb2}]%f - %F{#ebdbb2}[%F{#ebdbb2}%~%f%F{#ebdbb2}]%f - %F{#ebdbb2}[%f%F{#ffbb00}'%D{"%Y-%m-%d %I:%M:%S"}%f$'%F{#ebdbb2}]%f
%F{#ebdbb2}└─[%F{#fb4934}%?$(retcode)%f%F{#ebdbb2}] <$(mygit)$(hg_prompt_info)>%f '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

