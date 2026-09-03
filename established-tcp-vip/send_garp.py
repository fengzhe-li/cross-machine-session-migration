#!/usr/bin/env python3
import argparse
import fcntl
import socket
import struct
import time


SIOCGIFHWADDR = 0x8927
ETH_P_ARP = 0x0806
ARPHRD_ETHER = 0x0001
ETH_P_IP = 0x0800


def mac_bytes(mac):
    return bytes(int(part, 16) for part in mac.split(":"))


def iface_mac(iface):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    ifreq = struct.pack("256s", iface[:15].encode())
    result = fcntl.ioctl(sock.fileno(), SIOCGIFHWADDR, ifreq)
    return ":".join(f"{byte:02x}" for byte in result[18:24])


def arp_packet(operation, sender_mac, sender_ip):
    broadcast = b"\xff" * 6
    zero_mac = b"\x00" * 6
    smac = mac_bytes(sender_mac)
    sip = socket.inet_aton(sender_ip)

    ethernet = broadcast + smac + struct.pack("!H", ETH_P_ARP)
    arp = struct.pack(
        "!HHBBH6s4s6s4s",
        ARPHRD_ETHER,
        ETH_P_IP,
        6,
        4,
        operation,
        smac,
        sip,
        zero_mac if operation == 1 else broadcast,
        sip,
    )
    return ethernet + arp


def main():
    parser = argparse.ArgumentParser(
        description="Send Gratuitous ARP announcements without external arping."
    )
    parser.add_argument("--iface", required=True)
    parser.add_argument("--ip", required=True)
    parser.add_argument("--count", type=int, default=7)
    parser.add_argument("--interval", type=float, default=0.2)
    args = parser.parse_args()

    mac = iface_mac(args.iface)
    sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(ETH_P_ARP))
    sock.bind((args.iface, 0))

    request = arp_packet(1, mac, args.ip)
    reply = arp_packet(2, mac, args.ip)

    print(f"Sending Gratuitous ARP for {args.ip} from {mac} on {args.iface}")
    for _ in range(args.count):
      sock.send(request)
      sock.send(reply)
      time.sleep(args.interval)


if __name__ == "__main__":
    main()
