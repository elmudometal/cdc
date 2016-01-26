# Realizado por Hernan Guzman (Elmudometal)
# Bajo GNU GENERAL PUBLIC LICENSE Ver Terminos en:
# http://www.gnu.org/copyleft/gpl.html
#!/bin/bash
echo "Creando Archivos de Configuración..."
cat >$HOME/cdc.conf <<EOF
          %echo Generating a basic OpenPGP key
          Key-Type: RSA
          Key-Length: 2048
          Subkey-Type: DSA
          Subkey-Length: 2048
          Name-Real: ${1}
          Name-Comment: ${1} <${2}>
          Name-Email: ${2}
          Expire-Date: 0
          Passphrase: ${3}
          %pubring ${1}.pub
          %secring ${1}.sec
          # Do a commit here, so that we can later print "done" :-)
          %commit
          %echo done
EOF
echo "Archivos de Configuración Creados ..."
# sed -i "s|_NOMBRE_|${1}|g" $HOME/cdc.conf
# sed -i "s|_CORREO_|${2}|g" $HOME/cdc.conf
 echo "Creando llave GPG, espere mientras se realiza esta operación"
 echo "Esto podria llevar tiempo"
 echo "Mientras se realiza esta operación, abra un archivo o genere procesos para que la clave se obtenga de manera rápida"
 gpg --yes --batch --passphrase=${3} --gen-key $HOME/cdc.conf
 echo "Clave generada"
 echo "Importando clave GPG..."
 gpg --import $HOME/${1}.pub
 gpg --import $HOME/${1}.sec
 echo "Importanción de Clave GPG Finalizada."
 rm $HOME/cdc.conf
 gpg --list-key

