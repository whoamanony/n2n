n2n allow you create a peer to peer network convenient.

to see more about it please visit to <https://github.com/ntop/n2n>.

## image usage

firstly, you need a public network server to use n2n supernode do peer's connect.

- run supernode in public network server
```bash
docker run --rm --name n2n -dit -p 7654:7654/udp -p 7654:7654/tcp theanony/n2n:3.0 supernode -f -F p2p -p 7654
```

- run edge in home or office peer
```bash
docker run --rm --name n2n --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -dit theanony/n2n:3.0 edge -c community -l serverHost:7654 -f

# must add `--cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun` to the `docker run`, the tun module was required for n2n edge
```

show the peer ip
```bash
docker exec -it n2n ip addr | grep -oP "(?<=inet\s)\d+(\.\d+){3}(?=.+?edge)"
```

and you can use iptables to forward port to another node in the local network