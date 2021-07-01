ListLines, Off

#KeyHistory 0
#NoEnv
#SingleInstance Ignore

FIREWALL_RULE_NAME := "3f47a2266-e590-48bf-8724-781963250aa5"
FIREWALL_RULE_REMOTE_PORT := "27000-27200`,3097"

Menu, Tray, NoDefault
SetScrollLockState, Off
OnExit, ExitApp

Gosub, DeleteFirewallRule
Gosub, CreateFirewallRule
return

CreateFirewallRule:
Run, netsh advfirewall firewall add rule name="%FIREWALL_RULE_NAME%" dir=in  action=block enable=no remoteport="%FIREWALL_RULE_REMOTE_PORT%" protocol=tcp,, Hide UseErrorLevel
Run, netsh advfirewall firewall add rule name="%FIREWALL_RULE_NAME%" dir=in  action=block enable=no remoteport="%FIREWALL_RULE_REMOTE_PORT%" protocol=udp,, Hide UseErrorLevel
Run, netsh advfirewall firewall add rule name="%FIREWALL_RULE_NAME%" dir=out action=block enable=no remoteport="%FIREWALL_RULE_REMOTE_PORT%" protocol=tcp,, Hide UseErrorLevel
Run, netsh advfirewall firewall add rule name="%FIREWALL_RULE_NAME%" dir=out action=block enable=no remoteport="%FIREWALL_RULE_REMOTE_PORT%" protocol=udp,, Hide UseErrorLevel
return

DeleteFirewallRule:
Run, netsh advfirewall firewall del rule name="%FIREWALL_RULE_NAME%",, Hide UseErrorLevel
return

DisableFirewallRule:
Run, netsh advfirewall firewall set rule name="%FIREWALL_RULE_NAME%" new enable=no,, Hide UseErrorLevel                                                                                                                                                                                                                                            
FirewallRuleEnabled := 0
return

EnableFirewallRule:
Run, netsh advfirewall firewall set rule name="%FIREWALL_RULE_NAME%" new enable=yes,, Hide UseErrorLevel
FirewallRuleEnabled := 1
return

ExitApp:
Gosub, DeleteFirewallRule
ExitApp
return

ScrollLock::
if FirewallRuleEnabled := !FirewallRuleEnabled
{
    Gosub, EnableFirewallRule
    SetScrollLockState, On
}
else
{
    Gosub, DisableFirewallRule
    SetScrollLockState, Off
}
return
