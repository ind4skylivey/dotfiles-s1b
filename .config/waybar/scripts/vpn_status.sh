#!/bin/bash

get_vpn_status() {
    # Check for various VPN interfaces
    local vpn_interfaces=("tun0" "wg0" "ppp0" "vpn0")
    
    for iface in "${vpn_interfaces[@]}"; do
        if ip link show "$iface" > /dev/null 2>&1; then
            local status=$(ip link show "$iface" | grep "UP")
            if [ ! -z "$status" ]; then
                echo "󰒈"
                return 0
            fi
        fi
    done
    
    # Check for OpenVPN process
    if pgrep -x "openvpn" > /dev/null 2>&1; then
        echo "󰒈"
        return 0
    fi
    
    # Check for WireGuard
    if command -v wg &> /dev/null && wg show > /dev/null 2>&1; then
        echo "󰒈"
        return 0
    fi
    
    # Check NetworkManager VPN connections
    if command -v nmcli &> /dev/null; then
        local vpn_status=$(nmcli connection show --active 2>/dev/null | grep vpn)
        if [ ! -z "$vpn_status" ]; then
            echo "󰒈"
            return 0
        fi
    fi
    
    echo ""
}

get_vpn_status
