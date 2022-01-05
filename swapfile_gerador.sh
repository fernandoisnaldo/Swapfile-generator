#! /bin/bash
echo "Copiando o fstab para a home de: "
whoami
cp /etc/fstab ~/fstab.bkp
ls ~
echo "A partição onde fica /swapfile é Btrfs? (Y/n) "
read btr
if [!$btr]; then
    echo "Opção inválida"
    exit 1
elif [$btr = "y" || $btr = "Y"]; then
    sudo touch /swapfile
    sudo truncate -s 0 /swapfile
    sudo chattr +C /swapfile
    sudo btrfs property set /swapfile compression none
fi
echo "Informe o tamanho do arquivo swap em MB: "
read tamanho
sudo dd if=/dev/zero of=/swapfile bs=1M count=$tamanho status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "# Entrada de swapfile gerada por swapfile_generator.sh" >> /etc/fstab
sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
exit 0
