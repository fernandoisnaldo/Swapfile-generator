#! /bin/bash
echo "Copiando o fstab para a home de: "
whoami
cp /etc/fstab ~/fstab.bkp
ls ~
sudo su
echo "A partição onde fica /swapfile é Btrfs? (Y/n) "
read btr
if [!$btr]; then
    echo "Opção inválida"
    exit 1
elif [$btr = "y" || $btr = "Y"];
    touch /swapfile
    truncate -s 0 /swapfile
    chattr +C /swapfile
    btrfs property set /swapfile compression none
fi
echo "Informe o tamanho do arquivo swap em MB: "
read tamanho
dd if=/dev/zero of=/swapfile bs=1M count=$tamanho status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "# Entrada de swapfile gerada por swapfile_generator.sh" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
exit 0
