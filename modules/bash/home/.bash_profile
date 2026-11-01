#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Android SDK (antes en ~/.profile, que bash nunca leía)
if [[ -d /opt/android-sdk ]]; then
    export ANDROID_HOME=/opt/android-sdk
    _bt=$(printf '%s\n' "$ANDROID_HOME"/build-tools/* | sort -V | tail -n 1)
    for _d in "$_bt" "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools"; do
        [[ -d $_d && ":$PATH:" != *":$_d:"* ]] && PATH="$_d:$PATH"
    done
    export PATH
    unset _bt _d
fi
