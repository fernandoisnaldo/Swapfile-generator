#! /bin/bash
echo "Em que diretório você deseja que o arquivo swap esteja presente? (eg: ~/swapfile)"
read swapfile
echo "A partição onde fica /swapfile é Btrfs? (Y/n) "
read btr
if [!($btr)]; then
    echo "Opção inválida"
    exit 1
elif [$btr = "y" || $btr = "Y"]; then
    sudo touch $swapfile
    sudo truncate -s 0 $swapfile
    sudo chattr +C $swapfile
    sudo btrfs property set $swapfile compression none
fi
echo "Informe o tamanho do arquivo swap em MB: "
read tamanho
sudo dd if=/dev/zero of=$swapfile bs=1M count=$tamanho status=progress
sudo chmod 600 $swapfile
sudo mkswap $swapfile
sudo swapon $swapfile
exit 0
