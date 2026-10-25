function fixdesktops --description "Reload keyboard shortcuts and restart Dock (fixes Option+N desktop switching)"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    killall Dock
end
