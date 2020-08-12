hits_ip_dict = {}
with open("hits.txt") as file:
    for line in file.readlines():
        ip = (line.split("\t"))[1]
        if ip not in hits_ip_dict:
            hits_ip_dict[ip] = 0
        hits_ip_dict[ip] += 1
hits_ip_dict = sorted(hits_ip_dict.items(), key=lambda x: x[1], reverse = True)
print(', '.join([ip[0] for ip in hits_ip_dict[:5]]))