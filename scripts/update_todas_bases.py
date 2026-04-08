
import pexpect
import sys
import glob
import subprocess

def executarUpdate(database):

    oerp_py = '/opt/odoo/v_reforma/bin/python3'
    #oerp_py = '/home/publico/desenv/python39/bin/python3'
    oerp_conf = '/opt/odoo/porta2-reforma2.conf'
    #oerp_conf = '/home/publico/desenv/odoo/odoo14/odoo.conf'
    oerp_bin = "/opt/odoo/OCB/odoo-bin"
    #oerp_bin = "/home/publico/desenv/odoo/odoo14/OCB/odoo-bin"
    # executa = pexpect.spawn(oerp_py + ' ' + oerp_bin + ' -c ' + oerp_conf + ' -d ' + database + ' -u all --stop-after-init', encoding='utf-8')
    executa = oerp_py + ' ' + oerp_bin + ' -c ' + oerp_conf + ' -d ' + database + ' -u all --stop-after-init'
   
    pexpect.run(executa)

# -------------------------------------------------------------------
# Lê os arquivos conf do apache pra achar as bases da respetiva porta
# -------------------------------------------------------------------
porta = sys.argv[1]
path = "/etc/apache2/sites-available/*.conf"
linha_a_procurar = "ProxyPass /                    http://127.0.0.1:%s/ retry=0" %(porta)
comando = "grep -i '%s' /etc/apache2/sites-available/*.conf" %(linha_a_procurar)
resultado = subprocess.check_output(comando, shell=True, text=True)


dblist = []

for line in resultado.splitlines():
    dblist.append(line[29:line.find('.conf')])

# for filename in glob.glob(path):
#     with open(filename, 'r') as f:
#         # print(f.read())
#         for line in f:
#             if "ProxyPassReverse" in line and porta in line:
#                 dblist.append(line[:line.find('.conf')])

# arquivo = "/home/publico/tmp/porta_47069"
# with open(arquivo_gravar, 'r') as file:
#     for line in file:
#         # print(line.strip())
#         dblist.append(line[:line.find('.conf')])

for database in dblist:
    #with open(log_name, 'a') as log_file:
    #  if database in log_file.read():
    #    continue
    # Wait for server to upgrade database, then kill it
    msg = "atualizando {}...".format(database)
    print (msg)
    executarUpdate(database)
    msg = "ATUALIZADO {}...".format(database)
    print (msg)
print("FIM")
