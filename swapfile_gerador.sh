#! /bin/bash
echo "Em que diretório completo você deseja que o arquivo swap esteja presente? (eg: /swapfile)"
read swapfile
sudo touch $swapfile
sudo chattr +C $swapfile > /dev/null;
echo "Informe o tamanho do arquivo swap em MB: "
read tamanho
sudo dd if=/dev/zero of=$swapfile bs=1M count=$tamanho status=progress
sudo chmod 600 $swapfile
sudo mkswap $swapfile
sudo swapon $swapfile
echo "Dica: Você pode adicionar linha no fstab, caso deseje que o swapfile persista após reinicialização, por meio do seguinte comando:"
echo "echo \"$swapfile none swap defaults 0 0\" >> /etc/fstab"
exit 0
