#! /bin/bash
echo "Em que diretório você deseja que o arquivo swap esteja presente? (eg: ~/swapfile)"
read swapfile
sudo touch $swapfile
echo "A partição onde fica /swapfile é Btrfs? (Y/n) "
read btr
if [!$btr]; then
    echo "Opção inválida"
    exit 1
elif [$btr = "y" || $btr = "Y"]; then
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
echo "Dica: Caso você queira reutilizar o arquivo swap na próxima inicialização, adicione-o no fstab."
echo "Caso só queira reutiliza-lo em outra eventualidade, o comando é swapon /path/to/dir"
exit 0
