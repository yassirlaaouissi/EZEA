#Modified version of mgeeky's script (https://github.com/mgeeky/Penetration-Testing-Tools/blob/master/networks/smtpvrfy.py)
#!/usr/bin/python

import socket
import sys
import os


def interpret_smtp_status_code(resp):
    code = int(resp.split(' ')[0])
    messages = {
        250:'Requested mail action okay, completed', 
        251:'User not local; will forward to <forward-path>', 
        252:'Cannot VRFY user, but will accept message and attempt delivery', 
        502:'Command not implemented', 
        530:'Access denied (???a Sendmailism)', 
        550:'Requested action not taken: mailbox unavailable', 
        551:'User not local; please try <forward-path>', 
                                                                                }
    if code in messages.keys():
        return '({} {})'.format(code, messages[code])
    else:
        return '({} code unknown)'.format(code)

def vrfy(targetIP, username, timeout):

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(timeout)

    try:
        conn = s.connect((targetIP, 25))
    
    except socket.error, e:
        print '[!] Connection failed with {}:25 - "{}"'.format(targetIP, str(e))
        return False
                                                                     
    try:
        print '[+] Service banner: "{}"'.format(s.recv(1024).strip())
        s.send('HELO test@test.com\r\n')
        print '[>] Response for HELO from {}:{} - '.format(targetIP, 25) + s.recv(1024).strip()

    except socket.error, e:
        print '[!] Failed at initial session setup: "{}"'.format(str(e))
        return False

    s.send('VRFY ' + username + '\r\n')
    res = s.recv(1024).strip()

    print '[>] Response from {}:{} - '.format(server, port) + interpret_smtp_status_code(res)
    if 'User unknown' in res:
        print '[!] User not found.'
    elif (res.startswith('25') and username in res and '<' in res and '>' in res):
        print '[+] User found: "{}"'.format(res.strip())
    else:
        print '[?] Response: "{}"'.format(res.strip())

    s.close()

if __name__ == '__main__':
    targetIP = sys.argv[1]
    f = sys.argv[2]
    timeout = 10
    names = [] 
    with open(f, 'r') as fi:
        for a in fi:
            names.append(a.strip())
        print '[>] Provided wordlist file with {} entries.'.format(len(names))
        vrfy(targetIP, names, timeout)

