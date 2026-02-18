# Tips for Creating Packets

## Tips For Creating ICMP packets
- Figure out the length of your new icmp packet (hint: it will be the same length as the original packet if the original packet was an ICMP echo request. Otherwise, calculate it based on the size of the headers it will have).
- Create a new icmp packet (hint: use malloc)
- Get original ip packet’s headers
- Create new packet’s headers (hint: ethernet, IP and ICMP)
- Set appropriate fields in the headers (hints below)
- Send using sr_send_packet()
- Free memory after sending the packet

### struct sr_icmp_hdr 
- uint8_t icmp_type; (set to the type # you are sending)
- uint8_t icmp_code; (set to the code # you are sending)
- uint16_t icmp_sum; (initially set to 0, compute cksum over the icmp header)
- uint8_t data[ICMP_DATA_SIZE]; (don’t set if it’s an echo reply, otherwise original packet ip header)

### struct sr_ip_hdr
- uint8_t ip_tos; (just set to 0, as per reference binary) Don’t need to do this if you’re memsetting the IP header with the original IP header.
- uint16_t ip_len; (set to packet length minus ethernet header size)
- uint16_t ip_off; (just set to IP_DF, as per the reference binary) UPDATE: Don’t do this for echo replies.
- uint8_t ip_ttl; (set to something reasonable, e.g. TTL_INIT = 255)
- uint8_t ip_p; (set to ip_protocol_icmp)
- uint16_t ip_sum; (initially set to 0, compute cksum over the ip header)
- uint32_t ip_src, (set to ip of our interface or outgoing interface based on whether the original packet was destined for us or not)
- unint32_t ip_dst; (set to original packet’s ip_src )

###struct sr_ethernet_hdr
- uint8_t  ether_dhost[ETHER_ADDR_LEN]; (set to original packet’s ether_shost)
- uint8_t  ether_shost[ETHER_ADDR_LEN];  (set to outgoing interface’s addr)
- uint16_t ether_type;  (set to ethertype_ip)

## Tips for Creating ARP Replies
Create arp reply in response to arp requests that you receive
- Create a new arp packet (hint: use malloc, it’ll be the same length as the original arp packet).
- Get original arp packet’s headers
- Create new packet’s headers (hint: ethernet and ARP)
- Set appropriate fields in the headers (hints below)
- Send using sr_send_packet()
- Free memory after sending the packet

### struct sr_ethernet_hdr
- uint8_t  ether_dhost[ETHER_ADDR_LEN]; (set to original packet’s ether_shost)
- uint8_t  ether_shost[ETHER_ADDR_LEN];  (set to receiving interface’s addr)
- uint16_t ether_type;  (set to ethertype_arp) ***Fixed** sorry

### struct sr_arp_hdr
- unsigned short ar_hrd; (set to arp_hrd_ethernet)
- unsigned short ar_pro;  (set to ethertype_ip)
- unsigned char ar_hln; (set to length of a mac address)
- unsigned char ar_pln;  (set to length of an IP address)
- unsigned short ar_op; (set to ar_op_reply)
- unsigned char ar_sha[ETHER_ADDR_LEN];  (set to receiving interface’s addr)
- uint32_t ar_sip; (set to receiving interface’s ip)
- unsigned char ar_tha[ETHER_ADDR_LEN]; (set to original packet’s ether_shost)
- uint32_t ar_tip; (set to original packet’s sip)

### Tips For Creating ARP Requests
Create and send arp request packets based on sr_arpreqs that are queued during the IP forwarding process. Every time handle_arpreq() is called, create/recreate and send/resend arp packet if the current arpreq-> times_sent < 5 times (otherwise destroy the arpreq)

- Create a new arp packet (hint: use malloc, length will be the sum of the size of the headers).
- Create new packet’s headers (hint: ethernet and ARP)
- Set appropriate fields in the headers (hints below)
- Send using sr_send_packet()
- Free memory after sending the packet

### struct sr_ethernet_hdr
- uint8_t  ether_dhost[ETHER_ADDR_LEN]; (set to 0xff, since broadcasted)
- uint8_t  ether_shost[ETHER_ADDR_LEN];  (set to the current arpreq’s first packet’s interface’s addr)
- uint16_t ether_type;  (set to ethertype_arp)

### struct sr_arp_hdr
- unsigned short ar_hrd; (set to arp_hrd_ethernet)
- unsigned short ar_pro;  (set to ethertype_ip)
- unsigned char ar_hln; (set to length of a mac address)
- unsigned char ar_pln;  (set to length of an IP address)
- unsigned short ar_op; (set to ar_op_request)
- unsigned char ar_sha[ETHER_ADDR_LEN];  (set to the current arpreq’s first packet’s interface’s addr)
- uint32_t ar_sip; (set to current arpreq’s first packet’s interface’s ip)
- unsigned char ar_tha[ETHER_ADDR_LEN];  (set to 0xff, since broadcasted)
- uint32_t ar_tip; (set to current arpreq’s ip)

## Note
** Be aware that you may need to use htons() conversion for some values in these headers** In other parts of your code, you will equivalently need to use ntohs(), so just be aware of when to do the conversions. https://linux.die.net/man/3/htons 
